{ self, inputs, userSettings, ... }: {
    # ------------------------------------------------------------ #
    # ---------------------Per-User Variables--------------------- #
    # ------------------------------------------------------------ #
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







  flake.nixosModules.machineConfig = { pkgs, lib, ... }: {
    # import any other modules from here
    imports = [
      self.nixosModules.myMachineHardware
      self.nixosModules.bluetooth
      self.nixosModules.terminal

      self.nixosModules.niri
      self.nixosModules.basicTools
      self.nixosModules.securityTools

      self.nixosModules.syncthing
      self.nixosModules.development
      self.nixosModules.freetube
      self.nixosModules.chatApps
      self.nixosModules.music
      self.nixosModules.notes
      self.nixosModules.steam
      self.nixosModules.printingSlicer3D
      self.nixosModules.modelingSoftware
    ];
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    # ------------------------------------------------------------ #
    # ------------------\/--Generic Config--\/-------------------- #
    # ------------------------------------------------------------ #


    # Edit this configuration file to define what should be installed on
    # your system.  Help is available in the configuration.nix(5) man page
    # and in the NixOS manual (accessible by running ‘nixos-help’).
    services.udisks2.enable = true;
    services.gnome.gnome-keyring.enable = true;


    services.displayManager.defaultSession = "niri";

      # Bootloader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      # Use latest kernel.
      boot.kernelPackages = pkgs.linuxPackages_latest;

      networking.hostName = "${userSettings.username}"; # Define your hostname.
      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

      # Configure network proxy if necessary
      # networking.proxy.default = "http://user:password@proxy:port/";
      # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

      # Enable networking
      networking.networkmanager.enable = true;
      
      # Set your time zone.
      time.timeZone = "America/Phoenix";

      # Select internationalisation properties.
      i18n.defaultLocale = "en_US.UTF-8";

      i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
      };

      # Enable the X11 windowing system.
      # You can disable this if you're only using the Wayland session.
      services.xserver.enable = true;

      # Enable the KDE Plasma Desktop Environment.
      services.displayManager.sddm.enable = true;
      services.desktopManager.plasma6.enable = true;

      # Configure keymap in X11
      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };

      # Enable CUPS to print documents.
      services.printing.enable = true;

      # Enable sound with pipewire.
      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        #jack.enable = true;

        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
      };

      # Enable touchpad support (enabled default in most desktopManager).
      # services.xserver.libinput.enable = true;

      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users.${userSettings.username} = {
        isNormalUser = true;
        description = "${userSettings.username}";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
          kdePackages.kate
        #  thunderbird
        ];
      };

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search, run:
      # $ nix search wget
      environment.systemPackages = with pkgs; [
      #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      #  wget
        fish
        git
        udisks
      ];
      # syncthing config
      

      # Some programs need SUID wrappers, can be configured further or are
      # started in user sessions.
      # programs.mtr.enable = true;
      # programs.gnupg.agent = {
      #   enable = true;
      #   enableSSHSupport = true;
      # };

      # List services that you want to enable:

      # Enable the OpenSSH daemon.
      # services.openssh.enable = true;

      # Open ports in the firewall.
      # networking.firewall.allowedTCPPorts = [ ... ];
      # networking.firewall.allowedUDPPorts = [ ... ];
      # Or disable the firewall altogether.
      # networking.firewall.enable = false;

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "25.11"; # Did you read the comment?

    };





  }

