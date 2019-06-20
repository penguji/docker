#!/bin/bash
function install_rvm() {
  if ! (which rvm); then
    echo "========== Installing RVM.io =========="
    curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
    curl -fsSL "https://get.rvm.io" | bash -s stable --auto-dotfiles --autolibs=enable --ruby
    # Make RVM to be bash function in future shells
    echo 'source /usr/local/rvm/scripts/rvm' >> ~/.bashrc 
    source ~/.bashrc
  fi
  source /usr/local/rvm/scripts/rvm
  rvm list
}

function install_ruby() {
  echo "========== Installing Ruby $1... =========="
  # source /usr/local/rvm/scripts/rvm
  rvm install "ruby-${1}"
  gem install bundler -v 1.17.3 --no-ri --no-rdoc
}

function install_chromedriver() {
  if ! (which chromedriver); then
    CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`
    echo "========== Install Chromedriver $CHROMEDRIVER_VERSION =========="
    mkdir -p /app/chromedriver-$CHROMEDRIVER_VERSION
    curl -sS -o /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip
    unzip -qq /tmp/chromedriver_linux64.zip -d /app/chromedriver-$CHROMEDRIVER_VERSION
    rm /tmp/chromedriver_linux64.zip
    chmod +x /app/chromedriver-$CHROMEDRIVER_VERSION/chromedriver
    ln -fs /app/chromedriver-$CHROMEDRIVER_VERSION/chromedriver /usr/local/bin/chromedriver
  fi
  chromedriver -v
}

function install_node(){
  if ! (which node); then
    curl -sL https://deb.nodesource.com/setup_6.x | bash -
    apt-get install -y nodejs
  fi
}

install_rvm
install_ruby 2.6.0
install_ruby 2.5.1
install_node
install_chromedriver