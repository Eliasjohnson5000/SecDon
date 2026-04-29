{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Add host-specific packages here
    librewolf	#web browser
    
    kdePackages.kate	#code editor
    
    
    thunderbird	#email client
    
    arduino
    
    koreader  #document viewer
		nautilus  #file manager
		
		kicad	#PCB designer
		
		
		freecad	#3D design program
		  gsettings-desktop-schemas	#freecad dependancies
		  glib
		  gtk3
			adwaita-icon-theme
		
		
		
		signal-desktop	#secure messaging service

		freetube	#FOSS alternitive to youtube
		heroic
  ];
  
  environment.sessionVariables = {	#attempt to fix freecad
    XDG_DATA_DIRS = [ "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}" ];
  };
}


