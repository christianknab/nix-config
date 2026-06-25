{ inputs, ... }: {
  flake.nixosConfigurations.asahi = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.self.modules.nixos.asahi
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }
    ];
  };
}
