{ ... }: {
  flake.sharedModules.packages = { pkgs, config, ... }: {
    home-manager.users.${config.mainUser} = {
      home.packages = with pkgs; [ ripgrep fzf lazygit];
    };
  };
}
