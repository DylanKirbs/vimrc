#!/bin/bash
# This script will install and set up the .vimrc file
# Usage: ./install.sh [options]
# Options:
#   -h, --help      Display this help message
#   -n, --neovim    Install additional neovim init file

function cprint() {
    # Usage: cprint <text> <r> <g> <b>
    
    echo -e "\033[38;2;${2};${3};${4}m${1}\033[0m"
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -h|--help)
            echo "Usage: ./install.sh [options]"
            echo "Options:"
            echo "  -h, --help      Display this help message"
            echo "  -n, --newvim    Install additional files for neovim"
            exit 0
            ;;
        -n|--neovim)
            NVIM=true
            shift
            ;;
        *)
            cprint "Unknown option: $key" 255 0 0
            exit 1
            ;;
    esac
done

cprint "Checking system requirements..." 255 255 0
# sudo apt update
sudo apt install git
sudo apt install curl

if [ "$NVIM" = true ]; then
    sudo apt install neovim
else
    sudo apt install vim
fi

cprint "Installing .vimrc file..." 255 255 0
rm ~/.vimrc
cp .vimrc ~/.vimrc

if [ "$NVIM" = true ]; then
    cprint "Installing additional .vimrc for neovim..." 255 255 0
    mkdir -p ~/.config/nvim
    cp init.vim ~/.config/nvim/init.vim

    # source the init.vim file
    cprint "Sourcing init.vim file..." 255 255 0
    nvim +source\ ~/.config/nvim/init.vim +qall
else
    # source the .vimrc file
    cprint "Sourcing .vimrc file..." 255 255 0
    vim +source\ ~/.vimrc +qall
fi

cprint "Done!" 0 255 0
