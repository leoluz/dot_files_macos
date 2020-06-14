#! /usr/bin/env sh

script_dir=$(dirname $(python -c "import os; import sys; print(os.path.realpath(sys.argv[1]))" "$0"))

# Kitty setup
kitty_cfgdir="$HOME/.config/kitty"
mkdir -p $kitty_cfgdir
[ ! -f $kitty_cfgdir/kitty.conf ] && ln -s $script_dir/kitty.conf $kitty_cfgdir/kitty.conf
[ ! -d $kitty_cfgdir/kitty-themes ] && git clone git@github.com:dexpota/kitty-themes.git $kitty_cfgdir/kitty-themes
[ ! -d $kitty_cfgdir/kittens ] && mkdir $kitty_cfgdir/kittens && ln -s $script_dir/kitty/kittens/zoom_toggle.py $kitty_cfgdir/kittens/zoom_toggle.py
[ ! -f $kitty_cfgdir/theme.conf ] && ln -s $kitty_cfgdir/kitty-themes/themes/OneDark.conf $kitty_cfgdir/theme.conf
[ ! -f $kitty_cfgdir/wallpaper.png ] && ln -s $script_dir/wallpaper/eva.png $kitty_cfgdir/wallpaper.png
#[ ! -f $kitty_cfgdir/theme.conf ] && ln -s $kitty_cfgdir/kitty-themes/themes/Atom.conf $kitty_cfgdir/theme.conf

# Alacritty setup
alacritty_cfgdir="$HOME/.config/alacritty"
mkdir -p $alacritty_cfgdir
[ ! -f $alacritty_cfgdir/alacritty.yml ] && ln -s $script_dir/alacritty.yml $alacritty_cfgdir/alacritty.yml
[ ! -d $alacritty_cfgdir/eendroroy-theme ] && git clone git@github.com:eendroroy/alacritty-theme.git $alacritty_cfgdir/eendroroy-theme
[ ! -d $alacritty_cfgdir/williamson-theme ] && git clone https://github.com/aaron-williamson/base16-alacritty $alacritty_cfgdir/williamson-theme

# Tmux step
tmux_cfgdir="$HOME/.config/tmux"
mkdir -p $tmux_cfgdir
[ ! -d $tmux_cfgdir/kube-tmux ] && git clone git@github.com:jonmosco/kube-tmux.git $tmux_cfgdir/kube-tmux
[ ! -f $tmux_cfgdir/kube.sh ] && ln -s $tmux_cfgdir/kube-tmux/kube.tmux $tmux_cfgdir/kube.sh
[ ! -d $tmux_cfgdir/plugins ] && mkdir $tmux_cfgdir/plugins && git clone https://github.com/tmux-plugins/tpm $tmux_cfgdir/plugins/tpm
#vanilla
[ ! -f $HOME/.tmux.conf ] && ln -s $script_dir/tmux.conf $HOME/.tmux.conf
#oh-my-tmux
#[ ! -d $tmux_cfgdir/oh-my-tmux ] && git clone git@github.com:gpakosz/.tmux.git $tmux_cfgdir/oh-my-tmux
#[ ! -f $HOME/.tmux.conf ] && ln -s $tmux_cfgdir/oh-my-tmux/.tmux.conf $HOME/.tmux.conf
#[ ! -f $HOME/.tmux.conf.local ] && ln -s $script_dir/tmux.conf.local $HOME/.tmux.conf.local
# TODO check/install 'reattach-to-user-namespace' if in macos

# Misc setup
[ ! -f $HOME/.ad_profile ] && ln -s $script_dir/ad_profile $HOME/.ad_profile
[ ! -f $HOME/.zshrc ] && ln -s $script_dir/zshrc $HOME/.zshrc
[ ! -f $HOME/.gitconfig ] && ln -s $script_dir/gitconfig $HOME/.gitconfig
[ ! -f $HOME/.bash_profile ] && ln -s $script_dir/bash_profile $HOME/.bash_profile
