{ inputs, ... }: {
  flake.modules.nixos.asahi = { pkgs, ... }: {
    _class = "nixos";
    imports = [
      inputs.self.sharedModules.base
      inputs.self.sharedModules.zsh
      inputs.self.sharedModules.tmux
      inputs.self.sharedModules.direnv
      inputs.self.modules.nixos.base
    ];

    networking.hostName = "asahi";
  };
}
