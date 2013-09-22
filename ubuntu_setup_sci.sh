# This script will setup a scientific computing environment for
# Ubuntu Server 12.04.2 LTS (precise pangolin). This includes
# Multi-threaded OPENBlas
# R v3.0.1
# RSTUDIO-SERVER v0.97.551
# OCTAVE
# PYTHON

# install R
# add CRAN to source list
# sudo chmod 777 /etc/apt/sources.list
# sudo echo "deb http://http://cran.cnr.Berkeley.edu/bin/linux/ubuntu precise/" >> /etc/apt/sources.list
sudo apt-get -y upgrade
# Add marutter's R repositories
sudo add-apt-repository -y ppa:marutter/rdev
sudo add-apt-repository -y ppa:marutter/c2d4u
sudo apt-get -y update
sudo apt-get -y install liblapack3
sudo apt-get -y install libatlas-base-dev
sudo apt-get -y install libatlas3gf-sse2

# If you are going to build R from source add these
# sudo apt-get -y install gfortran
# sudo apt-get -y install g++
# sudo apt-get -y install xorg-dev
# sudo apt-get -y install libreadline-dev
# sudo apt-get -y install make
# sudo apt-get -y install openjdk-6-jdk
# sudo apt-get -y install tcl
# sudo apt-get -y install tk
# sudo apt-get -y install gdebi-core
# sudo apt-get -y install libapparmor1
# sudo apt-get -y install psmisc
# sudo apt-get -y install sqlite3

# Install R 
sudo apt-get -y install r-base r-base-dev

# Install R packages
R CMD javareconf -e
sudo chmod 777 -R /usr/local/lib/R
sudo chmod 777 -R /usr/lib/R
sudo echo 'options(repos = c(CRAN="http://cran.cnr.Berkeley.edu"))' >> /usr/lib/R/library/base/R/Rprofile

# Not all of these packages have been ported to 3
# sudo apt-get -y install r-cran-plyr r-cran-forecast r-cran-ggplot2 r-cran-doBy r-cran-foreach r-cran-gridExtra r-cran-lattice r-cran-markdown r-cran-nlme r-cran-randomForest r-cran-RColorBrewer r-cran-Rcpp r-cran-RcppArmadillo r-cran-reshape r-cran-reshape2 r-cran-rJava r-cran-Rserve r-cran-RSQLite r-cran-sandwich r-cran-scales r-cran-snow r-cran-sqldf r-cran-zoo r-cran-tseries r-cran-xts r-cran-knitr

# Install from CRAN
sudo R -e 'install.packages(c("plyr", "forecast", "ggplot2", "doBy", "foreach", "forecast", "gridExtra", "lattice", "markdown", "nlme", "randomForest", "RColorBrewer", "Rcpp", "RcppArmadillo", "reshape", "reshape2", "rJava", "rjson", "RJDBC", "Rserve", "RSQLite", "sandwich", "scales", "snow", "sqldf", "zoo", "stringr", "tseries", "xts", "knitr"))'

# Install R-STUDIO
wget http://download2.rstudio.org/rstudio-server-0.97.551-amd64.deb
sudo gdebi -y rstudio-server-0.97.551-amd64.deb


# Install Octave


# Install Python
