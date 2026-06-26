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

      # setting some custom settings
      system.defaults.CustomUserPreferences = {
        "com.apple.finder" = {
          _FXSortFoldersFirst = true;
          FXPreferredSearchViewStyle = "Nlsv";
          # When performing a search, search the current folder by default
          FXDefaultSearchScope = "SCcf";
          ShowPathbar = true;
        };
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.screensaver" =
          {
            askForPassword = 1;
            askForPasswordDelay = 0;
          };
        "com.apple.screencapture" = {
          location = "~/Downloads";
          type = "png";
        };
        "com.apple.symbolichotkeys" = {
          AppleSymbolicHotKeys = {
            # 30: "Save picture of selected area as a file"
            # Remapped to: Cmd + Ctrl + Shift + 4
            "30" = {
              enabled = true;
              value = {
                parameters = [ 65535 21 1441792 ]; # 1441792 = Cmd + Ctrl + Shift
                type = "standard";
              };
            };

            # 31: "Copy picture of selected area to clipboard"
            # Remapped to: Cmd + Shift + 4
            "31" = {
              enabled = true;
              value = {
                parameters = [ 65535 21 1179648 ]; # 1179648 = Cmd + Shift
                type = "standard";
              };
            };
          };
        };
      };

      system.activationScripts = (if (vars ? "defaultbrowser" && builtins.isString vars.defaultbrowser) then {
        postActivation.text = ''
          			# set deafult browser
          			${pkgs.defaultbrowser}/bin/defaultbrowser ${vars.defaultbrowser}
          			# make settings activate immediately without restart
          			/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
          		'';
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
        programs.fd.enable = true;
        programs.bat = {
          enable = true;
          config = {
            paging = "never";
            style = "plain";
          };
        };
        programs.zsh.shellAliases.open = "/usr/bin/open"; # open command gets messed up
      };
    };
}
