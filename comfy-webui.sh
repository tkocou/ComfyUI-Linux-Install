#!/usr/bin/env bash

echo "This script is derived from a script written by ParisNeo"
echo "It is used with the permission of ParisNeo (https://github.com/ParisNeo/lollms-webui)"

sleep 2

if ping -q -c 1 google.com >/dev/null 2>&1; then
    echo -e "\e[32mInternet Connection working fine\e[0m"
    # Install git
    echo -n "Checking for Git..."
    if command -v git > /dev/null 2>&1; then
      echo "is installed"
    else
      read -p "Git is not installed. Would you like to install Git? [Y/N] " choice
      if [ "$choice" = "Y" ] || [ "$choice" = "y" ]; then
        echo "Installing Git..."
        sudo apt update
        sudo apt install -y git
      else
        echo "Please install Git and try again."
        exit 1
      fi
    fi

    # Check if repository exists
    if [[ -d .git ]] ;then
    echo Pulling latest changes
    git pull origin master
    #git pull origin main
    else
      if [[ -d ComfyUI ]] ;then
        cd ComfyUI
      else
        echo Cloning repository...
        git clone https://github.com/comfyanonymous/ComfyUI.git ./ComfyUI
        cd ComfyUI
      fi
    fi
    echo Pulling latest version...
    git pull

    # Install Python 3.10 and pip
    echo -n "Checking for python3.10..."
    if command -v python3.10 > /dev/null 2>&1; then
      echo "is installed"
    else
      read -p "Python3.10 is not installed. Would you like to install Python3.10? [Y/N] " choice
      if [ "$choice" = "Y" ] || [ "$choice" = "y" ]; then
        echo "Installing Python3.10..."
        sudo apt update
        sudo apt install -y python3.10 python3.10-venv
      else
        echo "Please install Python3.10 and try again."
        exit 1
      fi
    fi

    # Install venv module
    echo -n "Checking for venv module..."
    if python3.10 -m venv env > /dev/null 2>&1; then
      echo "is installed"
    else
      read -p "venv module is not available. Would you like to install it? [Y/N] " choice
      if [ "$choice" = "Y" ] || [ "$choice" = "y" ]; then
        echo "Installing venv module..."
        sudo apt update
        sudo apt install -y python3.10-venv
      else
        echo "Please install venv module and try again."
        exit 1
      fi
    fi

    # Create a new virtual environment
    echo -n "Creating virtual environment..."
    python3.10 -m venv env
    if [ $? -ne 0 ]; then
      echo "Failed to create virtual environment. Please check your Python installation and try again."
      echo "You might try renaming the old ComfyUI directory and restart this script for a fresh install."
      echo "And then copy over the contents of the old ComfyUI directory into the fresh copy of ComfyUI."
      exit 1
    else
      echo "is created"
    fi
fi


# Activate the virtual environment
echo -n "Activating virtual environment..."
if source env/bin/activate ; then
  echo "is active"
else
  echo "is not active. Use the 'bash' shell instead of 'sh'."
  exit 1
fi
source env/bin/activate

# Install the required packages
echo "Installing requirements..."
python3.10 -m pip install pip --upgrade
python3.10 -m pip install --upgrade torchvision
python3.10 -m pip install --upgrade -r requirements.txt

if [ $? -ne 0 ]; then
  echo "Failed to install required packages. Please check your internet connection and try again."
  exit 1
fi




# Cleanup

if [ -d "./tmp" ]; then
  rm -rf "./tmp"
  echo "Cleaning tmp folder"
fi

# Launch the Python application
python main.py
