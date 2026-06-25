{ ... }: {
  flake.sharedModules.alacritty = { pkgs, config, ... }: {
    home-manager.users.${config.mainUser} = {
      programs.alacritty = {
        enable = true;
        settings = {
          # `defaults write -g AppleFontSmoothing -int 0` to stop mac bolding
          # ref: https://github.com/alacritty/alacritty/issues/4616
          font = {
            normal = {
              family = "JetBrainsMono Nerd Font";
              style = "Regular";
            };
            # bold = {
            #   family = "JetBrainsMono Nerd Font";
            #   style = "Bold";
            # };
            # italic = {
            #   family = "JetBrainsMono Nerd Font";
            #   style = "Italic";
            # };
            # bold_italic = {
            #   family = "JetBrainsMono Nerd Font";
            #   style = "Bold Italic";
            # };
            size = 13;
          };
          window = {
            opacity = 0.8;
              };
            terminal.shell = {
              program = "${pkgs.zsh}/bin/zsh";
            };
          };
        };
      };
    };
  }
