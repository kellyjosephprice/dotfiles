. ~/.aliases
. ~/.zshrc.shared
. ~/.zshrc.local

export PATH=$HOME/.local/bin:$PATH

export PATH=$PATH:/home/kelly/.spicetify

export WEZTERM_LOG=debug wezterm

eval "$(starship init zsh)"

# opencode
export PATH=/home/kelly/.opencode/bin:$PATH
