{
  self,
  inputs,
  config,
  lib,
  userSettings,
  ... }:{
  flake.nixosModules.terminal = { config, pkgs, lib, ...}:{
    environment.systemPackages = [
      pkgs.alacritty
    ];
    programs.fish = {
      enable = true;
      shellAliases = {


        # System aliases
        c = "clear";

        # NixOS specific
        ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";

        # Directory navigation shortcuts
        ".." = "cd ..";
        "..." = "cd ../..";
        ".3" = "cd ../../..";
        ".4" = "cd ../../../..";
        ".5" = "cd ../../../../..";

        

        # Always mkdir with parents
        mkdir = "mkdir -p";
      };
    };
    users.users.${userSettings.username} = {
      isNormalUser = true;
      shell = pkgs.fish;
    };
  };
}