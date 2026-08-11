{ self, inputs, ... }: {
  flake.nixosConfigurations.defaultConfig = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.machineConfig
      self.nixosModules.variables
    ];
  };


  flake.nixosConfigurations.variables = inputs.nixpkgs.lib.nixosSystem {
    _module.args = {
      userSettings = {
            # Git Configuration
            username = "default-user";
            syncthingName = "Framework";
            #gitUsername = "User"; # Unused
            #gitEmail = "placeholder@invalid.com"; # Unused

            # System Configuration
            #timeZone = "America/Phoenix"; # Unused

            # Monitor Settings (update after installation for your displays)
            #extraMonitorSettings = ''
            #  monitor=,preferred,auto,1
            #''; # Unused

            # Waybar Settings
            #clock24h = true; # Unused

            # Default Applications
            webBrowser = "librewolf";
            terminal = "kitty";
            fileBrowser = "thunar";
            lockscreen = "swaylock";
            #keyboardLayout = "us"; # Unused
            #consoleKeyMap = "us"; # Unused

            # For Nvidia Prime support (update if using nvidia-laptop profile)
            # Run 'lspci | grep VGA' to find your actual GPU IDs
            #intelID = "PCI:0:2:0"; # Unused
            #nvidiaID = "PCI:1:0:0"; # Unused

            # Core Featuresf
            #enableNFS = false; # Unused
            #printEnable = false; # Unused
            #thunarEnable = true; # Unused
            #stylixEnable = true; # Unused

            # Optional Features (disabled for faster initial install)
            # You can enable these later by setting to true and rebuilding
            #gamingSupportEnable = true;       # Gaming controllers, gamescope, protonup-qt         # Unused
            #flutterdevEnable = false;          # Flutter development environment                   # Unused
            #syncthingEnable = true;           # Syncthing file synchronization                     # Unused
            #enableCommunicationApps = false;   # Discord, Teams, Zoom, Telegram                    # Unused
            #enableExtraBrowsers = false;       # Vivaldi, Brave, Firefox, Chromium, Helium         # Unused
            #enableProductivityApps = true;    # Obsidian, GNOME Boxes, QuickEmu                    # Unused
            #aiCodeEditorsEnable = false;       # Claude-code, gemini-cli, cursor                   # Unused

            # Desktop Environment
            #enableHyprlock = false;  # Set to false if using DMS/Noctalia lock screens             # Unused

            # Bar/Shell Choice
            #barChoice = "noctalia";      # Options: "dms" or "noctalia"                            # Unused
            # NOTE: If you change barChoice to "dms", you must run 'dms-install' after rebuilding

            # Shell Choice
            #defaultShell = "fish";   # Options: "fish" or "zsh"         # Unused

            # Theming
            #stylixImage = ../../wallpapers/Artimis_II/EarthInTheCapsule.jpg; # Unused
            #waybarChoice = ../../modules/home/waybar/waybar-ddubs.nix;  # Waybar temporarily disabled
            #animChoice = ../../modules/home/hyprland/animations-end4.nix; # Unused

            # Startup Applications
            #startupApps = []; # Unused
      };
    };
  };
}