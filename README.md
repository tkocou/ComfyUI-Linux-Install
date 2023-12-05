# SDXL-linux-Install
A simple script to make installing ComfyUI node based AI in Linux easier.

Step 1) download the **comfy-webui.sh** file to your home directory.

Step 2) Open a terminal window and execute the next 2 commands.

**chmod +x comfy-webui.sh**  <<-- set the executable permission

**./comfy-webui.sh**  <<--  execute the script

Step 3) Lastly, after the script finishes, Press _Ctrl-C_ to quit.

Step 4) You will need to download 2 SDXL models and a SDXL VAE file.

For the 2 SDXL models:

https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0

https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0

And place the models into the _ComfyUI/models/checkpoints_ directory.

Download the VAE file from here: 

https://huggingface.co/stabilityai/sdxl-vae

And place the file in the _ComfyUI/models/vae_ directory.

Step 5) Any time you wish to start the server, in your home directory, simply start **./comfy-webui.sh**.

ComfyUI Github Repository: https://github.com/comfyanonymous/ComfyUI

By using the **comfy-webui.sh** script to start the ComfyUI AI, your copy of ComfyUI will be automatically
updated to the latest version of ComfyUI.

Older non-SDXL models can still be used. Copy those models into the _ComfyUI/models/checkpoints_ directory.
And the older VAEs as well, placing those into the _ComfyUI/models/vae_ directory.
