# declares a custom attribute 'sharedModules' on the flake output
# avoids OS-specific class restrictions (Darwin complainins a "common" class attribute is not "darwin")
{lib, ...}: {
  options.flake = {
    sharedModules = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.unspecified;
      default = {};
    };
  };
}
