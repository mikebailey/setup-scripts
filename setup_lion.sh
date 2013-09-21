# Notes for setting up a macbook pro with OSX 10.8. Incomplete.
# Download and install xcode and cli developer tools

# Install X11 from http://xquartz.macosforge.org/trac/wiki/X112.7.4

# Install homebrew
/usr/bin/ruby -e "$(curl -fsSkL http://raw.github.com/mxcl/homebrew/go)"

# isntall GNUplot
brew install gnuplot

# Install python
brew install python --universal --framework

# Install pip and virtual env
easy_install pip
pip install virtualenv
pip install virtualenvwrapper

# Make sure the following line is in bash
# source /usr/local/bin/virtualenvwrapper.sh
# You can now use
# workon
# mkvirtualenv data

# Install octave
brew tap homebrew/science
brew update && brew upgrade
brew install gfortran
brew install octave

setenv("GNUTERM","X11") >> OCTAVE_HOME/share/octave/site/m/startup/octaverc

# install random
brew install gdal
brew install tmux
brew install git

# Download iterm2
# install color themes
# Disable bell notifications
# 
