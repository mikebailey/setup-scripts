# This script will setup a scientific computing environment for
# Ubuntu Server 12.04.2 LTS (precise pangolin). This includes
# ATLAS
# LAPACK
# R v3.0.1
# RSTUDIO-SERVER v0.97.551
# OCTAVE
# PYTHON

# install ATLAS, LAPACK, and other dependencies
sudo apt-get -y upgrade
sudo apt-get -y update
sudo apt-get -y install libatlas-base-dev
sudo apt-get -y install libatlas3gf-sse2
sudo apt-get -y install gfortran
sudo apt-get -y install g++
sudo apt-get -y install xorg-dev
sudo apt-get -y install libreadline-dev
sudo apt-get -y install make
sudo apt-get -y install openjdk-6-jdk
sudo apt-get -y install tcl
sudo apt-get -y install tk
sudo apt-get -y install gdebi-core
sudo apt-get -y install libapparmor1
sudo apt-get -y install psmisc

# Install R and R-studio
sudo apt-get -y r-base-dev

wget http://download2.rstudio.org/rstudio-server-0.97.551-amd64.deb
sudo gdebi -y rstudio-server-0.97.551-amd64.deb

# Install R packages
sudo chmod -R 777 /usr/local/lib/R
sudo cat 'options(repos = c(CRAN="http://cran.cnr.Berkeley.edu"))' >> /usr/local/lib/R/library/base/R/Rprofile
R CMD javareconf -e
sudo R -e 'install.packages(c("plyr", "forecast", "ggplot2", "doBy", "foreach", "forecast", "gridExtra", "lattice", "markdown", "nlme", "randomForest", "RColorBrewer", "Rcpp", "RcppArmadillo", "reshape", "reshape2", "rJava", "rjson", "RJDBC", "Rserve", "RSQLite", "sandwich", "scales", "snow", "sqldf", "zoo", "stringr", "tseries", "xts"))'




# Install Octave


# Install Python
