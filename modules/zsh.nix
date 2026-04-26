{pkgs, ...}: {
  home-manager.users.christianknab = {...}: {
    programs.zsh = {
      enable = true;
      oh-my-zsh.enable = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;

      plugins = [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.8.0";
            sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
          };
        }
      ];

      shellAliases = {
        rcat = "command cat";
        cat = "bat";
        ls = "eza --group-directories-first --icons=auto";
        la = "ls -A";
        lt = "eza --tree --level=2 --long --icons --git";
        lta = "lt -a";
        cd = "zd";
        myrsync = "rsync -ah --partial --info=progress2,stats2";
      };

      initContent = ''
        if [ -z "$TMUX" ] && [ "$TERM_PROGRAM" != "vscode" ]; then tmux attach -t main || tmux new -s main; fi
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        source ${./data/.p10k.zsh}

        setopt GLOB_DOTS
        zstyle ':completion:*' special-dirs false
        zstyle ':completion:*:cd:*' tag-order 'directories'

        zd() {
          if [ $# -eq 0 ]; then
            builtin cd ~ && return
          elif [ -d "$1" ]; then
            builtin cd "$1"
          else
            z "$@"
          fi
        }
        compdef _cd zd

        open() {
          nohup xdg-open "$@" >/dev/null 2>&1 &
        }
      '';
    };
  };
}
