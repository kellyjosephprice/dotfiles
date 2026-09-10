{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.gh ];

  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      user = {
        name = "Kelly Joseph Price";
        email = "kellyjosephprice@gmail.com";
      };

      alias = {
        clean-branches = "!git branch | rg -v ' (master|next)$' | grep -v '*' | xargs git branch -D";
      };

      core = {
        pager = "less -F -X";
        # old value had a stray trailing quote (hooksPath = ~/.config/git/hooks')
        # which made it invalid ini - fixed here. The directory doesn't exist
        # yet either; create ~/.config/git/hooks if you actually add hooks.
        hooksPath = "~/.config/git/hooks";
        excludesfile = "~/.gitignore";
      };

      diff = {
        tool = "vimdiff";
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };

      merge = {
        tool = "vimdiff";
        conflictstyle = "diff3";
      };

      credential = {
        helper = "store";
        "https://github.com".helper = [ "" "!gh auth git-credential" ];
        "https://gist.github.com".helper = [ "" "!gh auth git-credential" ];
      };

      url."git@github.com:".insteadOf = "https://github.com/";

      pull = {
        ff = "only";
        rebase = true;
      };

      remote.pushDefault = "origin";
      advice.skippedCherryPicks = false;
      column.ui = "auto";
      branch.sort = "-committerdate";
      tag.sort = "version:refname";
      init.defaultBranch = "main";

      push = {
        default = "simple";
        autoSetupRemote = true;
        followTags = true;
      };

      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };

      help.autocorrect = 5;
      commit.verbose = true;

      rerere = {
        enabled = true;
        autoupdate = true;
      };

      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };
    };
  };

  home.file.".gitignore".text = ''
    **/.claude/settings.local.json
  '';
}
