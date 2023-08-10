#!/bin/bash

# This script will install and set up the .vimrc file
# Usage: ./install.sh [options]
# Options:
#   -h, --help      Display this help message
#   -n, --neovim    Install additional neovim init file

# Parse arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -h|--help)
            echo "Usage: ./install.sh [options]"
            echo "Options:"
            echo "  -h, --help      Display this help message"
            echo "  -f, --force     Force overwrite of existing .vimrc file"
            echo "  -v, --vim       Install for vim instead of neovim"
            exit 0
            ;;
        -n|--neovim)
            NVIM=true
            shift
            ;;
        *)
            echo "Unknown option: $key"
            exit 1
            ;;
    esac
done

echo "Installing .vimrc file..."
cp .vimrc ~/.vimrc

if [ "$NVIM" = true ]; then
    echo "Installing additional .vimrc for neovim..."
    cp init.vim ~/.config/nvim/init.vim

    # source the init.vim file
    echo "Sourcing init.vim file..."
    nvim +source\ ~/.config/nvim/init.vim +qall
else
    # source the .vimrc file
    echo "Sourcing .vimrc file..."
    vim +source\ ~/.vimrc +qall
fi

echo "Done!"
