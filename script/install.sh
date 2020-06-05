#! /usr/bin/env bash

# Install homebrew
case "$(uname -s)" in
    Darwin)
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        ;;
    Linux)
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
        eval $(/home/homebrew/.linuxbrew/bin/brew shellenv)
        ;;
esac

brew install git

brew install hub

brew cask install ngrok

cd $HOME
git clone leoluz/vimfiles .vim
