#! /usr/bin/env sh

# current_script_dir will resolve the location of the invoked
# script. If the provided script is a symlink, it will resolve
# and return the target location
current_script_dir() {
    SOURCE=${BASH_SOURCE[0]}
    # resolve $SOURCE until the file is no longer a symlink
    while [ -L "$SOURCE" ]; do 
        DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
        SOURCE=$(readlink "$SOURCE")
        # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
        [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE 
    done
    echo $( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
}
script_dir=$(current_script_dir)

# Kitty setup
kitty_cfgdir="$HOME/.config/kitty"
[ ! -d $kitty_cfgdir ] && mkdir -p $kitty_cfgdir
[ ! -L $kitty_cfgdir/kitty.conf ] && ln -s $script_dir/kitty.conf $kitty_cfgdir/kitty.conf
[ ! -d $kitty_cfgdir/kitty-themes ] && git clone --depth 1 git@github.com:dexpota/kitty-themes.git $kitty_cfgdir/kitty-themes
[ ! -d $kitty_cfgdir/tokyonight-theme ] && git clone --depth 1 git@github.com:folke/tokyonight.nvim.git $kitty_cfgdir/tokyonight-theme
[ ! -d $kitty_cfgdir/kittens ] && mkdir $kitty_cfgdir/kittens && ln -s $script_dir/kitty/kittens/zoom_toggle.py $kitty_cfgdir/kittens/zoom_toggle.py
[ ! -L $kitty_cfgdir/wallpaper.png ] && ln -s $script_dir/wallpaper/eva.png $kitty_cfgdir/wallpaper.png
[ ! -L $kitty_cfgdir/theme.conf ] && ln -s $kitty_cfgdir/tokyonight-theme/extras/kitty_tokyonight_night.conf $kitty_cfgdir/theme.conf
[ ! -L $kitty_cfgdir/session.conf ] && ln -s $script_dir/kitty/session.conf $kitty_cfgdir/session.conf

# Oh-my-zsh setup
ohmyzsh_cfgdir="$HOME/.oh-my-zsh"
[ ! -d $ohmyzsh_cfgdir ] && git clone git@github.com:ohmyzsh/ohmyzsh.git $ohmyzsh_cfgdir

# Misc setup
[ ! -L $HOME/.it_profile ] && ln -s $script_dir/it_profile $HOME/.it_profile
[[ -f $HOME/.zshrc || -L $HOME/.zshrc ]] && rm $HOME/.zshrc
ln -s $script_dir/zshrc $HOME/.zshrc
[[ -f $HOME/.gitconfig || -L $HOME/.gitconfig ]] && rm $HOME/.gitconfig 
ln -s $script_dir/gitconfig $HOME/.gitconfig
