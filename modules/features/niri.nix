{
  self,
  inputs,
  config,
  lib,
  niriSettings,
  ... }:
  {
  flake.nixosModules.niri = { config, pkgs, lib, niriSettings, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
        ];
        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input.keyboard.xkb.layout = "us,ua";

        layout.gaps = 5;

        binds = {



    # ------------------------------------------------------------ #
    # ---------------------Defualt Niri Config-------------------- #
    # ------------------------------------------------------------ #
              # Primary Binds
          "Mod+Return".spawn-sh = lib.getExe pkgs.${niriSettings.Terminal};
          "Mod+T".spawn-sh = lib.getExe pkgs.kitty;
          "Mod+Q".close-window = _:{};

              # Movement Binds



          #   Noctalia Binds
          "Mod+space".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";


        };
      };
    };
  };
}
