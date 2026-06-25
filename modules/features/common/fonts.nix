{ ... }: {
  flake.sharedModules.fonts = { pkgs, config, lib, ... }: {
    home-manager.users.${config.mainUser} = {
      home.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
    };
  };
}
