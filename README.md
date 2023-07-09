# SDXL-linux-Install
A simple script to make installing SDXL ComfyUI node based AI in Linux easier.

Step 1) download the webui.sh file to your home directory.

Step 2) Open a terminal window and execute the next 2 commands

Step 3) chmod +x webui.sh  <<-- set the executable permission

Step 4) ~/webui.sh  <<--  execute the script

Step 5) Lastly, after the script finishes, Press Ctrl-C to quit.

Step 6) You will need to download 2 SDXL models and a SDXL VAE file.

For the 2 SDXL models, follow the instructions in this Reddit posting: 
https://www.reddit.com/r/StableDiffusion/comments/14sacvt/how_to_use_sdxl_locally_with_comfyui_how_to/
And place them in the _ComfyUI/models/checkpoints_ directory. If you are having trouble locating the files,
Use the torrent file.

Download the VAE file from here: https://huggingface.co/stabilityai/sdxl-vae/tree/main
And place the file in the _ComfyUI/models/vae_ directory

Step 7) Then move the webui.sh file into the newly created ComfyUI directory **mv webui.sh ComfyUI**. 
Any time you wish to start the server, simply **cd ~/ComfyUI** and then **./webui.sh**

ComfyUI Github Repository: https://github.com/comfyanonymous/ComfyUI

By using the **webui.sh** script to start the SDXL ComfyUI AI, your copy of ComfyUI will be automatically
updated to the latest version of ComfyUI.
