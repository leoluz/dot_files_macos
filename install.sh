#! /usr/bin/env sh

script_dir=$(dirname $(python -c "import os; import sys; print(os.path.realpath(sys.argv[1]))" "$0"))

# Kitty setup
kitty_cfgdir="$HOME/.config/kitty"
mkdir -p $kitty_cfgdir
[ ! -f $kitty_cfgdir/kitty.conf ] && ln -s $script_dir/kitty.conf $kitty_cfgdir/kitty.conf
[ ! -d $kitty_cfgdir/kitty-themes ] && git clone git@github.com:dexpota/kitty-themes.git $kitty_cfgdir/kitty-themes
[ ! -f $kitty_cfgdir/theme.conf ] && ln -s $kitty_cfgdir/kitty-themes/themes/Atom.conf $kitty_cfgdir/theme.conf

# Alacritty setup
alacritty_cfgdir="$HOME/.config/alacritty"
mkdir -p $alacritty_cfgdir
[ ! -f $alacritty_cfgdir/alacritty.yml ] && ln -s $script_dir/alacritty.yml $alacritty_cfgdir/alacritty.yml
[ ! -d $alacritty_cfgdir/eendroroy-theme ] && git clone git@github.com:eendroroy/alacritty-theme.git $alacritty_cfgdir/eendroroy-theme
[ ! -d $alacritty_cfgdir/williamson-theme ] && git clone https://github.com/aaron-williamson/base16-alacritty $alacritty_cfgdir/williamson-theme

# Misc setup
[ ! -f $HOME/.ad_profile ] && ln -s $script_dir/ad_profile $HOME/.ad_profile
[ ! -f $HOME/.zshrc ] && ln -s $script_dir/zshrc $HOME/.zshrc
[ ! -f $HOME/.tmux.conf ] && ln -s $script_dir/tmux.conf $HOME/.tmux.conf
[ ! -f $HOME/.gitconfig ] && ln -s $script_dir/gitconfig $HOME/.gitconfig
[ ! -f $HOME/.bash_profile ] && ln -s $script_dir/bash_profile $HOME/.bash_profile
