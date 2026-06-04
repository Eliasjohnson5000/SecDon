{ pkgs, ... }:

{
  gtk = {
    iconTheme = {
      name = "Tela-purple-dark";
      package = pkgs.tela-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4 = {
      #theme = null; # fixed an evaluation warning
		  extraConfig = {
		    gtk-application-prefer-dark-theme = 1;
		  };
		};
  };
}
