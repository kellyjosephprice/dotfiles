{ config, lib, pkgs, binder-wave, ... }:

{
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    baseIndex = 1;
    historyLimit = 10000;
    terminal = "tmux-256color";
    shell = "${pkgs.zsh}/bin/zsh"; # old value was /bin/zsh, which doesn't exist on NixOS

    plugins = with pkgs.tmuxPlugins; [
      sensible
    ];

    extraConfig = ''
      source-file ${binder-wave}/plugins/tmux/binder-wave.tmux.conf

      bind-key P command-prompt -p 'save history to filename:' -I '~/tmux.history' 'capture-pane -S -32768 ; save-buffer %1 ; delete-buffer'

      set -ag terminal-overrides ",xterm-256color:RGB"
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # colored underscores

      set-option -g status-keys vi
      set-option -g status-position top
      set-option -g bell-action any
      set-option -g set-titles on
      set-option -g set-titles-string '#H:#S.#I.#P #W #T'
      set-option -g visual-bell off

      setw -g monitor-activity on
    '';
  };
}
