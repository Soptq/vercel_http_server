#!/bin/bash
# author: Soptq

function install_nodejs() {
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    if [ -x "$(command -v apt)" ]; then
      # Debian based
      echo "INSTALLING NODEJS..."
      apt install nodejs
      apt install npm
    elif [ -x "$(command -v yum)" ]; then
      # Redhat based
      echo "INSTALLING NODEJS..."
      curl -sL https://rpm.nodesource.com/setup_14.x | sudo bash -
      yum clean all && sudo yum makecache fast
      yum install -y gcc-c++ make
      yum install -y nodejs
    else
      # Can not handle
      echo "CURRENTLY NOT SUPPORT YOUR OS"
      exit 1
    fi
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Macos
    if ! [ -x "$(command -v brew)" ]; then
      # Intall brew
      echo "INSTALLING HOMEBREW..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    else
      echo "DETECTED EXISTED HOMEBREW..."
    fi
    # Use brew to install nodejs
    echo "INSTALLING NODEJS..."
    brew install node
  else
    # Can not handle
    echo "CURRENTLY NOT SUPPORT YOUR OS"
    exit 1
  fi
}

function main() {

  # Check and install nodejs
  echo "------------------------------------------------------"
  echo "CHECKING NODEJS..."
  echo "------------------------------------------------------"
  if ! [ -x "$(command -v npm)" ]; then
    echo "INSTALLING NODEJS..."
    install_nodejs
  else
    nodejs_version="$(node -v)"
    echo "DETECTED EXISTED NODEJS $nodejs_version ..."
  fi

  # Standard procedure
  echo "------------------------------------------------------"
  echo "BUILDING..."
  echo "------------------------------------------------------"
  npm install --production
  node app.js
  curl http://127.0.0.1:5002
}

main
