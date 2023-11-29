#!/bin/python3

import os

os.system("sudo apt-get update")
os.system("cp -r .* ~/.")
goodies = ["iw", "net-tools", "g++", "git", "vim", "xclip", "cowsay", "hollywood", "tmux", "real-vnc", "curl", "ca-certificates", "gnupg", "gcc"]
for goody in goodies:
    os.system(f"sudo apt-get install -y {goody}")
os.system("git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim")
os.system("vim +'PluginInstall' +qa")
os.system("source ~/.vimrc")
os.system("source ~/.bashrc")
os.system("export TERMINAL=gnome-terminal")
os.system("sudo install -m 0755 -d /etc/apt/keyrings")
os.system("curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg")
os.system("sudo chmod a+r /etc/apt/keyrings/docker.gpg")
os.system("echo \"deb [arch=\"$(dpkg --print-architecture)\" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \"$(. /etc/os-release && echo \"$VERSION_CODENAME\")\" stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null")
os.system("sudo apt-get update")
os.system("sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin")
os.system("git clone git@github.com:egel/tmux-gruvbox.git")
os.system("cat tmux-gruvbox/tmux-gruvbox-dark.conf >> ~/.tmux.conf")
os.system("cp -r coolScripts ~/.")

"""
Run Gogh to set term colour
os.system("bash -c "$(wget -qO- https://git.io/vQgMr)"")
"""
