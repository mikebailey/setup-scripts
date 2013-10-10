# This script will setup a scientific computing environment for
# Ubuntu Server 12.04.2 LTS (precise pangolin). This includes
# Multi-threaded OPENBlas
# R v3.0.1 + libraries
# RSTUDIO-SERVER v0.97.551
# OCTAVE v3.2.4
# Anaconda PYTHON 2.7.5, 3.3 in virtualenvs includes
# an obscene amount of scientific libraries

# Install preliminaries
# add marutters R respositories
sudo add-apt-repository -y ppa:marutter/rdev
sudo add-apt-repository -y ppa:marutter/c2d4u
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install libopenblas-base mlocate r-base r-base-dev python-dev python-pip python-virtualenv
sudo updatedb

# dotfiles
git clone https://github.com/mikebailey/dotfiles.git
bash dotfiles/makesymlinks.sh

# Install Python and virtualenv
sudo mkdir ~/.virtualenvs
sudo pip install virtualenvwrapper
sudo /bin/zsh ~/.zshrc
sudo chmod 777 -R ~/.virtualenvs/

# install anaconda distribution
wget http://09c8d0b2229f813c1b93-c95ac804525aac4b6dba79b00b39d1d3.r79.cf1.rackcdn.com/Anaconda-1.7.0-Linux-x86_64.sh
bash Anaconda-1.7.0-Linux-x86_64.sh -b

# install a conda 2.7 and 3.3 env
conda create -n py27 python=2.7 anaconda
conda create -n py33 python=3.3 anaconda

# Install R packages
sudo chmod 777 -R /usr/local/lib
sudo chmod 777 -R /usr/lib/R
sudo chmod 777 -R /usr/local/bin

sudo echo 'options(repos = c(CRAN="http://cran.cnr.Berkeley.edu"))' >> /usr/lib/R/library/base/R/Rprofile
sudo R -e 'install.packages(c("plyr", "forecast", "ggplot2", "doBy", "foreach", "forecast", "gridExtra", "lattice", "markdown", "nlme", "randomForest", "RColorBrewer", "Rcpp", "RcppArmadillo", "reshape", "reshape2", "rjson", "Rserve", "RSQLite", "sandwich", "scales", "snow", "sqldf", "zoo", "stringr", "tseries", "xts", "knitr"))'

# Install R-STUDIO
sudo apt-get -y install gdebi-core libapparmor1
wget http://download2.rstudio.org/rstudio-server-0.97.551-amd64.deb
sudo gdebi -n rstudio-server-0.97.551-amd64.deb

# Create user rstudio and add to group rstudio_users; only allow users from this group to login
sudo addgroup rstudio_users
sudo useradd -d /home/ubuntu/rstudio_test2 -s /bin/false -p `openssl passwd rstudio` rstudio
sudo adduser rstudio rstudio_users

sudo mkdir -p /etc/rstudio/rserver
sudo chmod 777 -R /etc/rstudio/rserver
echo "auth-required-user-group=rstudio_users" >> /etc/rstudio/rserver/conf

sudo /usr/sbin/rstudio-server verify-installation
sudo /usr/sbin/rstudio-server restart

# Install Octave
sudo apt-get install -y octave
