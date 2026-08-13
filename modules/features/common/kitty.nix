{ ... }: {
  flake.sharedModules.kitty = { pkgs, config, ... }: {
    home-manager.users.${config.mainUser} = {
      programs.kitty = {
        enable = true;
        settings = {
          font_family = "Hack Nerd Font";
          font_size = "14";
          background_opacity = "0.6";
          hide_window_decorations = "yes";
          shell = "${pkgs.zsh}/bin/zsh";
        };
      };
    };
  };
}
