{pkgs, ...}: {
  home-manager.users.christianknab = {...}: {
    programs.tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = catppuccin;
          extraConfig = ''
            set -g @catppuccin_flavor 'mocha'
            set -g @catppuccin_window_status_style "rounded"
          '';
        }
        # {
        #   plugin = fingers;
        #   extraConfig = ''
        #     set -g @fingers-hint-style "bg=red,fg=black,bold"
        #     set -g @fingers-backdrop-style "dim"
        #     set -g @fingers-highlight-style "bg=green,fg=black"
        #   '';
        # }
      ];
      extraConfig = builtins.readFile ./data/.tmux.conf;
    };
  };
}
