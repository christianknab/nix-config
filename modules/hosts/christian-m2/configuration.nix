{inputs, ...}: {
  # specific config for the mac
  flake.modules.darwin.christian-m2 = {pkgs, ...}: {
    _class = "darwin";
    imports = [
      # cross-platform features
      inputs.self.sharedModules.base
      inputs.self.sharedModules.zsh
      inputs.self.sharedModules.tmux
      inputs.self.sharedModules.direnv
      # macOS specific features
      inputs.self.modules.darwin.base
      inputs.self.modules.darwin.gui
    ];

    nixpkgs.hostPlatform = "aarch64-darwin";
    networking.hostName = "christianknab";

    home-manager.users.christianknab = {pkgs, ...}: {
      home.stateVersion = "24.11";
      home.packages = [
        pkgs.opencode
        pkgs.sl
      ];
      programs.zoxide.enable = true;
      programs.eza.enable = true;
      programs.bat = {
        enable = true;
        config = {
          paging = "never";
          style = "plain";
        };
      };
    };
  };
}
