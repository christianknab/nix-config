{ inputs, ... }: {
  # defines the actual system output for this host
  flake.darwinConfigurations."christian-m2" = inputs.nix-darwin.lib.darwinSystem {
    modules = [
      inputs.self.modules.darwin.christian-m2
      inputs.home-manager.darwinModules.home-manager
      inputs.nix-homebrew.darwinModules.nix-homebrew
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
}
