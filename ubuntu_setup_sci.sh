# This script will setup a scientific computing environment for
# Ubuntu Server 12.04.2 LTS (precise pangolin). This includes
# Multi-threaded OPENBlas
# R v3.0.1 + libraries
# RSTUDIO-SERVER v0.97.551
# OCTAVE
# PYTHON

# install R
# add CRAN to source list
# sudo chmod 777 /etc/apt/sources.list
# sudo echo "deb http://http://cran.cnr.Berkeley.edu/bin/linux/ubuntu precise/" >> /etc/apt/sources.list
# Add marutter's R repositories
sudo add-apt-repository -y ppa:marutter/rdev
sudo add-apt-repository -y ppa:marutter/c2d4u
sudo apt-get -y upgrade
sudo apt-get -y update
sudo apt-get -y install libopenblas-base libatlas3gf-base

# Note: If you are going to build R from source you may need some of these
# sudo apt-get -y install gfortran g++ xorg-dev libreadline-dev make tcl tk psmic sqlite3

# Install R 
sudo apt-get -y install r-base r-base-dev

# Install R packages
sudo chmod 777 -R /usr/local/lib/R
sudo chmod 777 -R /usr/lib/R
sudo echo 'options(repos = c(CRAN="http://cran.cnr.Berkeley.edu"))' >> /usr/lib/R/library/base/R/Rprofile

# Not all of these packages have been ported to 3
# sudo apt-get -y install r-cran-plyr r-cran-forecast r-cran-ggplot2 r-cran-doBy r-cran-foreach r-cran-gridExtra r-cran-lattice r-cran-markdown r-cran-nlme r-cran-randomForest r-cran-RColorBrewer r-cran-Rcpp r-cran-RcppArmadillo r-cran-reshape r-cran-reshape2 r-cran-rJava r-cran-Rserve r-cran-RSQLite r-cran-sandwich r-cran-scales r-cran-snow r-cran-sqldf r-cran-zoo r-cran-tseries r-cran-xts r-cran-knitr

# Install from CRAN instead
sudo R -e 'install.packages(c("plyr", "forecast", "ggplot2", "doBy", "foreach", "forecast", "gridExtra", "lattice", "markdown", "nlme", "randomForest", "RColorBrewer", "Rcpp", "RcppArmadillo", "reshape", "reshape2", "rjson", "Rserve", "RSQLite", "sandwich", "scales", "snow", "sqldf", "zoo", "stringr", "tseries", "xts", "knitr"))'

# For RJDBC, need java support
# R CMD javareconf -e
# sudo apt-get -y install openjdk-6-jdk

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

# Install dotfiles
git clone https://github.com/mikebailey/dotfiles.git
cd ~/dotfiles
bash ./makesymlinks.sh
cd ~

# Install Python
sudo apt-get install -y python-pip python-virtualenv
sudo mkdir ~/.virtualenvs
sudo pip install virtualenvwrapper
sudo /bin/zsh ~/.zshrc
sudo chmod 777 -R ~/.virtualenvs/

mkvirtualenv data2

# Nice things to have
sudo apt-get install -y mlocate
sudo updatedb
