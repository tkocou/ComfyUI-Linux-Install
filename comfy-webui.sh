#!/usr/bin/env bash

echo "This script is derived from a script written by ParisNeo"
echo "It is used with the permission of ParisNeo (https://github.com/ParisNeo/lollms-webui)"

sleep 2

## Feel free to revise thie python version as you need it to be (i.e. older versions)

PYTHON="python3.13"
PYVENV="python3.13-venv"

## This next variable, if you have multiple GPUs available
## change the number from the default of '0' to the desired
## GPU to use, like '1' as an example
GPU_TO_RUN_ON="0"

## Key ComfyUI CLI runtime arguments include:
#
## --use-sage-attention: Enables SAGE Attention optimization for faster processing (CUDA only). ￼
## --fast: Activates fast processing features, though it may cause OOM issues on some systems. ￼
## --reserve-vram=<MB>: Specifies the amount of VRAM to reserve (e.g., --reserve-vram=2 for 2GB). ￼
## --lowvram / --novram: Enables low or ultra-low VRAM modes for systems with limited memory. ￼
## --disable-pinned-memory: Disables pinned memory allocation, which can resolve recurring CUDA errors. ￼
## --listen <IP> and --port <N>: Configures network access, allowing external connections (e.g., --listen 0.0.0.0). ￼
## --cpu: Forces the application to run entirely on the CPU.
## --enable-cors: Enables CORS headers for API access. 
#
## Some runtime options for ComfyUI; feel free to modify them!

COMFYUI_OPTIONS="--normalvram --fast --use-sage-attention"

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

    # Install Python 3.10 and pip : Update python = 3.11
    echo -n "Checking for "$PYTHON"..."
    if command -v $PYTHON > /dev/null 2>&1; then
      echo "is installed"
    else
      read -p $PYTHON" is not installed. Would you like to install "PYTHON"? [Y/N] " choice
      if [ "$choice" = "Y" ] || [ "$choice" = "y" ]; then
        echo "Installing "$PYTHON"..."
        sudo apt update
        sudo apt install -y $PYTHON $PYVENV
      else
        echo "Please install "$PYTHON" and try again."
        exit 1
      fi
    fi

    # Install venv module
    echo -n "Checking for venv module..."
    if $PYTHON -m venv env > /dev/null 2>&1; then
      echo "is installed"
    else
      read -p "venv module is not available. Would you like to install it? [Y/N] " choice
      if [ "$choice" = "Y" ] || [ "$choice" = "y" ]; then
        echo "Installing venv module..."
        sudo apt update
        sudo apt install -y $PYVENV
      else
        echo "Please install venv module and try again."
        exit 1
      fi
    fi

    # Create a new virtual environment
    echo -n "Creating virtual environment..."
    $PYTHON -m venv env
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
$PYTHON -m pip install pip --upgrade
$PYTHON -m pip install --upgrade torchvision
$PYTHON -m pip install --upgrade -r requirements.txt

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
python main.py --cuda-device $GPU_TO_RUN_ON  $COMFYUI_OPTIONS
