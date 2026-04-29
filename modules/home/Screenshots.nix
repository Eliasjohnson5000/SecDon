{config, pkgs, ...}:
{
	services.flameshot = {
	  enable = true;
	  package = pkgs.flameshot;
	  #grim package
	};

}

