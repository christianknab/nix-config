{ ... }: {
  flake.sharedModules.tmux = { pkgs, config, ... }: {
    home-manager.users.${config.mainUser} = {
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
        ];
        extraConfig = builtins.readFile ../../data/.tmux.conf;
      };
    };
  };
}
