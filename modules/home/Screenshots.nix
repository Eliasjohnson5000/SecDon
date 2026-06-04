{config, pkgs, ...}:
{
	services.flameshot = {
	  enable = true;
	  settings.General = {
		useGrimAdapter = true;
		#stops warnings for using GrimAdapter
		disabledGrimWarning = true;
	  };
	};
}

