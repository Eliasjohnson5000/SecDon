{userSettings, ...}: {

  flake.nixosModules.syncthing = { pkgs, lib, ... }: {
    services.syncthing = {
      enable = true;
      user = "${userSettings.syncthingName}";
      dataDir = "/home/${userSettings.username}";  # default location for new folders
      configDir = "/home/${userSettings.username}/.config/syncthing";
    };
  };
}