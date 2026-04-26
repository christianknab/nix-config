{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    import-tree.url = "github:vic/import-tree";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
    ...
  }: let
    configuration = {pkgs, ...}: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [
        pkgs.vim
      ];

      nix.enable = false;
      programs.zsh.enable = true;

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;
      security.pam.services.sudo_local.touchIdAuth = true;
      security.pam.services.sudo_local.text = "auth sufficient pam_tid.so.2";

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      users.users.christianknab.home = "/Users/christianknab";
    };
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Christians-MacBook-Air
    darwinConfigurations."Christians-MacBook-Air" = nix-darwin.lib.darwinSystem {
      modules =
        [
          configuration
          home-manager.darwinModules.home-manager
          (inputs.import-tree ./modules)
        ]
        ++ [
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.christianknab = {pkgs, ...}: {
              home.stateVersion = "24.11";
              home.packages = [
                pkgs.opencode
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
          }
        ];
    };
  };
}
