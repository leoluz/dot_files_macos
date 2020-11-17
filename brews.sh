brew install git
brew install go
brew install hub
brew install tree
brew install pstree
brew install node
brew install kubectl
brew install coreutils
brew install fzf
$(brew --prefix)/opt/fzf/install
brew install ripgrep
brew install java11
brew install svn #required for installing fira fonts :(
brew tap homebrew/cask-fonts
brew cask install \
  font-fira-code \
  font-fira-mono \
  font-fira-mono-for-powerline \
  font-fira-sans \
  font-menlo-for-powerline \
  font-fira-code-nerd-font \
  font-hack-nerd-font
brew install --HEAD neovim
brew cask install google-cloud-sdk
brew cask install kitty
