# This script will setup a scientific computing environment for
# Ubuntu Server 12.04.2 LTS (precise pangolin). This includes
# Multi-threaded OPENBlas
# R v3 (or most recent CRAN version) + some ML/stats libraries
# RSTUDIO-SERVER v0.97.551
# OCTAVE (most recent dist version)
# PYTHON 2.7.5, 3.3 in virtualenvs includes
# an obscene amount of scientific libraries

# Install preliminaries
sudo chmod 666 /etc/apt/sources.list
sudo echo 'deb http://cran.cnr.berkeley.edu/bin/linux/ubuntu/ precise/' >> /etc/apt/sources.list
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -
sudo apt-get -y update && sudo apt-get -y upgrade
sudo apt-get -y install libopenblas-base libopenblas-dev mlocate r-base r-base-dev python-dev python-pip python-virtualenv gdebi-core libapparmor1
sudo updatedb
sudo update-alternatives --set liblapack.so.3gf  /usr/lib/lapack/liblapack.so.3gf

# dotfiles
git clone https://github.com/mikebailey/dotfiles.git
bash dotfiles/makesymlinks.sh

# Install Python and virtualenv
sudo mkdir ~/.virtualenvs
sudo pip install virtualenvwrapper
sudo chmod 777 -R ~/.virtualenvs/

# install anaconda distribution
wget http://09c8d0b2229f813c1b93-c95ac804525aac4b6dba79b00b39d1d3.r79.cf1.rackcdn.com/Anaconda-1.7.0-Linux-x86_64.sh
bash Anaconda-1.7.0-Linux-x86_64.sh -b

# install a conda 2.7 and 3.3 env
anaconda/bin/conda create -n py27 python=2.7 anaconda --yes
anaconda/bin/conda create -n py33 python=3.3 anaconda --yes

sudo chmod 777 -R /usr/lib/R
sudo chmod 777 -R /usr/local/lib/R
sudo R CMD javareconf
# Install R packages
sudo echo 'options(repos = c(CRAN="http://cran.cnr.Berkeley.edu"))' >> /usr/lib/R/library/base/R/Rprofile
sudo R -e 'install.packages(c("plyr", "ggplot2", "doBy", "foreach", "forecast", "gridExtra", "lattice", "markdown", "nlme", "randomForest", "RColorBrewer", "Rcpp", "RcppArmadillo", "reshape", "reshape2", "rjson", "Rserve", "RSQLite", "sandwich", "scales", "snow", "sqldf", "zoo", "stringr", "tseries", "xts", "knitr", "forecast", "sqldf", "lubridate", "mlr", "e1071", "arules", "arulesViz", "arulesClassify", "arulesNBMiner", "arulesSequences", "class", "rpart", "ada", "SuppDists"), dependencies=TRUE)'

# Install R-STUDIO
wget http://download2.rstudio.org/rstudio-server-0.97.551-amd64.deb
sudo gdebi -n rstudio-server-0.97.551-amd64.deb

# Create user rstudio and add to group rstudio_users; only allow users from this group to login
sudo addgroup rstudio_users
sudo useradd -m -s /bin/bash -p `openssl passwd rstudio` rstudio
sudo adduser rstudio rstudio_users

echo "auth-required-user-group=rstudio_users" >> /etc/rstudio/rserver.conf
echo "r-cran-repos=http://cran.cnr.berkeley.edu/" >> /etc/rstudio/rsession.conf

sudo /usr/sbin/rstudio-server verify-installation
sudo /usr/sbin/rstudio-server restart

# Install Octave
sudo apt-get install -y octave

sudo chsh -s $(which zsh) $(id -un)
sudo reboot
