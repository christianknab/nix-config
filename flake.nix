{
  description = "Christians nix-config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
  };

  outputs = inputs:
  # flake-parts to structure the flake outputs
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.flake-parts.flakeModules.modules
        # sharedModules option def
        ./modules/features/common/options.nix
        # import everything in the modules directory
        (inputs.import-tree ./modules)
      ];
      systems = ["aarch64-darwin" "aarch64-linux" "x86_64-linux"];
    };
}
