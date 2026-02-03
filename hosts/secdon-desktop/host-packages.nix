{ config, pkgs, inputs,  ... }:
#let
#  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/#archive/master.tar.gz";
#in
{
  environment.systemPackages = with pkgs; [
	inputs.nixos-conf-editor.packages.${system}.nixos-conf-editor
	
    # Add host-specific packages here
		#Browsers
	librewolf
	firefox

	thunderbird	#email client

	
	#Security Tools
	protonvpn-gui
	opensnitch-ui
	
	swaylock
	swayidle
	
	
	#tlp	#battery optimization
	
	#notes #doesnt work

	freetube	#FOSS alternitive to youtube
	
  ];


  services = {
    tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      # Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 20; # 40 and below it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80;  # 80 and above it stops charging
    };
  };
  
  
  opensnitch.enable = true;
  
  
  };





						#  Home Manager
						



  home-manager.users.eliasj = {
    /* The home.stateVersion option does not have a default and must be set */
    home.packages = [
	#pkgs.librewolf
    
    
    ];

services.swayidle =
let
  # Lock command
  lock = "${pkgs.swaylock}/bin/swaylock --daemonize";
  # TODO: modify "display" function based on your window manager
  # Sway
  # display = status: "${pkgs.sway}/bin/swaymsg 'output * power ${status}'";
  # Hyprland
  # display = status: "hyprctl dispatch dpms ${status}";
  # Niri
   display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
in
{
  enable = true;
  timeouts = [
    {
      timeout = 120; # in seconds
      command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
    }
    {
      timeout = 125;
      command = lock;
    }
    {
      timeout = 160;
      command = display "off";
      resumeCommand = display "on";
    }
    {
      timeout = 200;
      command = "${pkgs.systemd}/bin/systemctl suspend";
    }
  ];
  events = [
    {
      event = "before-sleep";
      # adding duplicated entries for the same event may not work
      command = (display "off") + "; " + lock;
    }
    {
      event = "after-resume";
      command = display "on";
    }
    {
      event = "lock";
      command = (display "off") + "; " + lock;
    }
    {
      event = "unlock";
      command = display "on";
    }
  ];
};

    /* Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ]; */
  };
}
