{
  self,
  inputs,
  config,
  lib,
  userSettings,
  ... }:{
    flake.nixosModules.printingSlicer3D = { config, pkgs, lib, ...}:{
        environment.systemPackages = [
            pkgs.prusa-slicer
        ];
    };

    flake.nixosModules.modelingSoftware = { config, pkgs, lib, ...}:{
        environment.systemPackages = [
            pkgs.freecad
        ];
    };
}