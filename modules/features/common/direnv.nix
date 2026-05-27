{ ... }: {
  flake.sharedModules.direnv = { config, ... }: {
    home-manager.users.${config.mainUser} = {
      programs.direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
    };
  };
}
