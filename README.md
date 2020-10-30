# dotfiles

## TODO

* setup instructions
* host-specific config

### Setup

* install zsh git tmux neovim curl
* `sudo chsh -s /bin/zsh $USER`
* set git repo [Archwiki](https://wiki.archlinux.org/index.php/Dotfiles)
* * add remote
* * checkout master
* install tpm for tmux
* [install nvim plugins](#vim-plug)

### vim-plug
```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
