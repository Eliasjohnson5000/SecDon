{ config, ...}
{
  services.opensnitch.enable = true;	# firewall like application
  
  enviorment.systemPackages = with pkgs; [
    protonvpn-gui	#VPN
    
    opensnitch-ui	#UI for opensnitch
  ]
}
