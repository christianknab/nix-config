{...}: {
  # system settings and options shared across all machines
  flake.sharedModules.base = {
    pkgs,
    lib,
    ...
  }: {
    options.mainUser = lib.mkOption {
      type = lib.types.str;
      default = "christianknab";
    };

    config = {
      nix.settings.experimental-features = ["nix-command" "flakes"];
      nixpkgs.config.allowUnfree = true;
    };
  };
}
