dotfiles
========

rc files including .screenrc, .vimrc, .bashrc, etc.

$ cd && for file in `ls -a git/dotfiles/ | egrep -v '^[.]*$'`; do \
    ln -s git/dotfiles/$file $file; \
done

