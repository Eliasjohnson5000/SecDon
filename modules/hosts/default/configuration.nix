{ self, inputs, ... }: {

  flake.nixosModules.myMachineConfiguration = { pkgs, lib, ... }: {
    # import any other modules from here
    imports = [
      self.nixosModules.myMachineHardware
      self.nixosModules.niri
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
    # ------------------------------------------------------------ #
    # -----------------------User Variables----------------------- #
    # ------------------------------------------------------------ #


    # Git Configuration
    gitUsername = "Eliasjohnson5000";
    gitEmail = "eliasjohnson941@gmail.com";

    # System Configuration
    timeZone = "America/Phoenix";

    # Monitor Settings (update after installation for your displays)
    extraMonitorSettings = ''
      monitor=,preferred,auto,1
    '';

    # Waybar Settings
    clock24h = true;

    # Default Applications
    browser = "librewolf";
    terminal = "kitty";
    keyboardLayout = "us";
    consoleKeyMap = "us";

    # For Nvidia Prime support (update if using nvidia-laptop profile)
    # Run 'lspci | grep VGA' to find your actual GPU IDs
    intelID = "PCI:0:2:0";
    nvidiaID = "PCI:1:0:0";

    # Core Features
    enableNFS = false;
    printEnable = false;
    thunarEnable = true;
    stylixEnable = true;

    # Optional Features (disabled for faster initial install)
    # You can enable these later by setting to true and rebuilding
    gamingSupportEnable = true;       # Gaming controllers, gamescope, protonup-qt
    flutterdevEnable = false;          # Flutter development environment
    syncthingEnable = true;           # Syncthing file synchronization
    enableCommunicationApps = false;   # Discord, Teams, Zoom, Telegram
    enableExtraBrowsers = false;       # Vivaldi, Brave, Firefox, Chromium, Helium
    enableProductivityApps = true;    # Obsidian, GNOME Boxes, QuickEmu
    aiCodeEditorsEnable = false;       # Claude-code, gemini-cli, cursor

    # Desktop Environment
    enableHyprlock = false;  # Set to false if using DMS/Noctalia lock screens

    # Bar/Shell Choice
    barChoice = "noctalia";      # Options: "dms" or "noctalia"
    # NOTE: If you change barChoice to "dms", you must run 'dms-install' after rebuilding

    # Shell Choice
    defaultShell = "fish";   # Options: "fish" or "zsh"

    # Theming
    stylixImage = ../../wallpapers/Artimis_II/EarthInTheCapsule.jpg;
    #waybarChoice = ../../modules/home/waybar/waybar-ddubs.nix;  # Waybar temporarily disabled
    animChoice = ../../modules/home/hyprland/animations-end4.nix;

    # Startup Applications
    startupApps = [];




























    # ------------------------------------------------------------ #
    # ------------------\/--Generic Config--\/-------------------- #
    # ------------------------------------------------------------ #


    # Edit this configuration file to define what should be installed on
    # your system.  Help is available in the configuration.nix(5) man page
    # and in the NixOS manual (accessible by running ‘nixos-help’).

      # Bootloader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      # Use latest kernel.
      boot.kernelPackages = pkgs.linuxPackages_latest;

      networking.hostName = "nixos"; # Define your hostname.
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
      users.users.eliasj = {
        isNormalUser = true;
        description = "elias-j";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
          kdePackages.kate
        #  thunderbird
          proton-vpn
          opensnitch-ui
          librewolf
          obsidian
        ];
      };

      # Install firefox.
      programs = {
        firefox.enable = true;
      };
      services.opensnitch.enable = true;

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search, run:
      # $ nix search wget
      environment.systemPackages = with pkgs; [
      #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      #  wget
        fish
        git
      ];
      # syncthing config
      services.syncthing = {
        enable = false;
        user = "Framework";
        dataDir = "/home/eliasj";  # default location for new folders
        configDir = "/home/eliasj/.config/syncthing";
      };

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

