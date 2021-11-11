#!/usr/bin/env bash
# _   _ __  __
#| | | |  \/  |
#| |_| | |\/| | Made by Haider Mirza
#|  _  | |  | | My Github: https://github.com/Ha1derMirza
#|_| |_|_|  |_|
# NAME: HMOS
# DESC: Same an HM-configs and HM-Apps. Installs the entire package.
# WARNING: Run this script at your own risk.
if [ "$(id -u)" = 0 ]; then
    echo "##################################################################"
    echo "This script MUST NOT be run as root user since it makes changes"
    echo "to the \$HOME directory of the \$USER executing this script."
    echo "The \$HOME directory of the root user is, of course, '/root'."
    echo "We don't want to mess around in there. So run this script as a"
    echo "normal user. You will be asked for a sudo password when necessary."
    echo "##################################################################"
    exit 1
fi

error() { \
    clear; printf "ERROR:\\n%s\\n" "$1" >&2; exit 1;
}

echo "################################################################"
echo "## Syncing the repos and installing 'dialog' if not installed ##"
echo "################################################################"
sudo pacman --noconfirm --needed -Sy dialog git || error "Error syncing the repos."

welcome() { \
    dialog --colors --title "\Z7\ZbInstalling DTOS!" --msgbox "\Z4This is a script is what I call HMOS. Its basically just installs my configs into your system.\\n\\n-DT (Haider Mirza)" 16 60

    dialog --colors --title "\Z7\ZbStay near your computer!" --yes-label "Continue" --no-label "Exit" --yesno "\Z4This script is not allowed to be run as root, but you will be asked to enter your sudo password at various points during this installation. This is to give PACMAN the necessary permissions to install the software.  So stay near the computer." 8 60
}

welcome || error "User choose to exit."

lastchance() { \
    dialog --colors --title "\Z7\ZbInstalling DTOS!" --msgbox "\Z4WARNING! The DTOS installation script is currently in public beta testing. There are almost certainly errors in it; therefore, it is strongly recommended that you not install this on production machines. It is recommended that you try this out in either a virtual machine or on a test machine." 16 60

    dialog --colors --title "\Z7\ZbAre You Sure You Want To Do This?" --yes-label "Begin Installation" --no-label "Exit" --yesno "\Z4Shall we begin installing DTOS?" 8 60 || { clear; exit 1; }
}

lastchance || error "User choose to exit."


echo "###########################################"
echo "## Installing my configs to /usr/HMconf/ ##"
echo "###########################################"

sudo mkdir /usr/HMconf/
cd /usr/HMconf/
sudo git clone --depth 1 https://github.com/Haider-Mirza/.dotfiles /usr/HMconf/.dotfiles
sudo git clone --depth 1 https://github.com/Haider-Mirza/HMScripts /usr/HMconf/HMScripts
sudo git clone --depth 1 https://github.com/Haider-Mirza/HM-Emacs /usr/HMconf/HM-Emacs


echo "##########################################"
echo "## Copying My configs to Home directory ##"
echo "##########################################"

# Copying HMScripts to ~/.local/bin
cd /usr/HMconf/HMScripts/
cp -rf Scripts/* $HOME/.local/bin

# Copying HM-Emacs to ~/.emacs.d/
cd /usr/HMconf/HMScripts/
