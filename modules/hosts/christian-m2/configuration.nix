{ inputs, ... }: {
  # specific config for the mac
  flake.modules.darwin.christian-m2 = { pkgs, ... }:
    let
      vars = { defaultbrowser = "librewolf"; };
    in
    {
      _class = "darwin";
      imports = [
        # cross-platform features
        inputs.self.sharedModules.base
        inputs.self.sharedModules.zsh
        inputs.self.sharedModules.tmux
        inputs.self.sharedModules.direnv
        inputs.self.sharedModules.alacritty
        inputs.self.sharedModules.fonts
        inputs.self.sharedModules.packages
        # macOS specific features
        inputs.self.modules.darwin.base
        inputs.self.modules.darwin.gui
        inputs.self.modules.darwin.settings
      ];

      nixpkgs.hostPlatform = "aarch64-darwin";
      networking.hostName = "christianknab";

      environment.systemPackages = with pkgs; [
        rustup
      ] ++ (if (vars? "defaultbrowser" && builtins.isString vars.defaultbrowser) then [ pkgs.defaultbrowser ] else [ ]);

      system.activationScripts = (if (vars ? "defaultbrowser" && builtins.isString vars.defaultbrowser) then {
        postActivation.text = "${pkgs.defaultbrowser}/bin/defaultbrowser ${vars.defaultbrowser}";
      } else { });

      home-manager.users.christianknab = { pkgs, ... }: {
        home.stateVersion = "24.11";
        home.packages = [
          pkgs.opencode
          pkgs.sl
          pkgs.neovim
          pkgs.stow
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
