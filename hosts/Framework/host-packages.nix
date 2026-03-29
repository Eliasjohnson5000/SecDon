{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Add host-specific packages here
    librewolf	#web browser
    
    thunderbird	#email client
    
    arduino
    
    koreader  #document viewer
		nautilus  #file manager
		
		#kicad	#PCB designer
		
		signal-desktop	#secure messaging service

		freetube	#FOSS alternitive to youtube
  ];
}
