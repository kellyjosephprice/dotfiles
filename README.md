# dotfiles

### Setup

Install packages:
```
$ sudo apt install zsh git tmux neovim curl ripgrep
```

Switch to `zsh`:
```
$ sudo chsh -s /bin/zsh $USER
```

* setup ssh
* * setup ssh-agent
    `ssh-add .ssh/id_rsa`
* [set git repo](#dot)
* [install nvim plugins](#vim-plug)
* [install tmux plugins](#tpm)

### dot

inspo: [Archwiki](https://wiki.archlinux.org/index.php/Dotfiles)

```
mkdir git
cd git
git clone --bare git@github.com:kellyjosephprice/dotfiles.git dotfiles
alias dot='/usr/bin/git --git-dir=$HOME/dit/dotfiles/ --work-tree=$HOME'
cd
dot restore --staged .
dot restore .
```

### vim-plug

```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

### tpm

```
tmux source ~/.tmux.conf
ctrl+a I
```

### TPM

ctrl+a I
