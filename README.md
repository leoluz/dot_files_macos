MacOS X configuration files
===========================

About
-----

I maintaing my MacOS configuration files in this repo in order to reuse it in different computers.

Feel free to use it if it makes sense to you. :)

Instalation
-----------

Clone this repo in your home directory.

    $ cd ~
    $ ln -s ./dot_files_macos/bash_profile .bash_profile
    $ ln -s ./dot_files_macos/ideavimrc .ideavimrc
    $ cp ./dot_files_macos/gitconfig .gitconfig

Edit the `.gitconfig` file and add the missing configuration indicated.

Additional Instalations
-----------------------

### Homebrew

    $ ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

### Ruby environment

    $ brew install rbenv ruby-build
    $ rbenv install 2.1.2 #or newer version
    $ rbenv global 2.1.2

### Groovy environment

    $ curl -s get.gvmtool.net | bash
    $ gvm install groovy
    $ gvm install gradle

References
----------

* homebrew: http://brew.sh/
* rbenv: https://github.com/sstephenson/rbenv
* gvm: http://gvmtool.net/
