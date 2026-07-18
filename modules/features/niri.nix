{
  self,
  inputs,
  config,
  lib,
  userSettings,
  ... }:
  {
  flake.nixosModules.niri = { config, pkgs, lib, userSettings, ... }: {
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
          (lib.getExe self'.packages.myNoctalia)  #spawns noctallia on startup
        ];
        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite; #enables x11 apps (for compatability)

        input = {
          keyboard.xkb.layout = "us,ua";  #keyboard layout
          mouse = {
            accel-profile = "flat"; #acceloration curve for the mouse
          };
          touchpad = {
            tap = _:{}; #enables tap to click
            natural-scroll = _:{};  #enables natural scroll (push down to scroll up);
          };
          focus-follows-mouse = _:{}; #focus window follows the mouse
          warp-mouse-to-focus = _:{}; #Mouse warps to newly selected window
        };

        layout = {
            gaps = 9;

            center-focused-column = "never";
            always-center-single-column = _:{};

            preset-column-widths = [
                {proportion = 0.5; }
                {proportion = 0.66667; }
                {proportion = 1.0; }
            ];

            default-column-width  = _:{proportion = 0.5; };

            border = {
                width = 2;
                active-color   = "#0f2495";
                inactive-color = "#0d2084";
                urgent-color   = "#d8ab4f";
            };

            focus-ring ={
                off = _:{};
                width = 2;
                active-color   = "#808080";
                inactive-color = "#505050";
            };

            shadow = {
                softness = 30;
                spread = 5;
                offset  = _:{x=0; y=5;};
                color = "#0007";
            };

            struts = {
            };
        };






        binds = {
                    #TODO: finish formating
    # ------------------------------------------------------------ #
    # -------------------Default Niri Keybinds-------------------- #
    # ------------------------------------------------------------ #
          #   "(Keybind)".(Function) = (Argument*)
          # *if needed.
          # ' _:{}; ' is equlivlent to nothing

          # === Basic Binds == #
          "Mod+Return".spawn-sh                 = lib.getExe pkgs.${userSettings.terminal}; #Spawns terminal
          "Mod+T".spawn-sh                      = lib.getExe pkgs.${userSettings.terminal}; # ^^
          "Mod+Q".close-window                  = _:{};
          "Mod+Shift+Slash".show-hotkey-overlay = _:{};

                  ##==--< Window Management >--==##
          # === Basic Window Management === #
          "Mod+X".toggle-overview               = _:{};
          "Mod+Shift+F".fullscreen-window       = _:{};
          "Mod+F".maximize-column               = _:{};
          "Mod+W".toggle-window-floating        = _:{};
          "Mod+Ctrl+W".switch-focus-between-floating-and-tiling = _:{};
          "Mod+V".toggle-column-tabbed-display  = _:{};

          # === Focus Navigation === #
          "Mod+Left".focus-column-left = _:{};
          "Mod+Down".focus-window-down = _:{};
          "Mod+Up".focus-window-up = _:{};
          "Mod+Right".focus-column-right = _:{};
          #"Mod+H".focus-column-left = _:{};
          #"Mod+J".focus-window-down = _:{};
          #"Mod+K".focus-window-up = _:{};
          #"Mod+L".focus-column-right = _:{};

          # === Window Movement === #
          "Mod+Ctrl+Left".move-column-left = _:{};
          "Mod+Ctrl+Down".move-window-down = _:{};
          "Mod+Ctrl+Up".move-window-up = _:{};
          "Mod+Ctrl+Right".move-column-right = _:{};
          "Mod+Ctrl+H".move-column-left = _:{};
          "Mod+Ctrl+J".move-window-down = _:{};
          "Mod+Ctrl+K".move-window-up = _:{};
          "Mod+Ctrl+L".move-column-right = _:{};

          # === Column Navigation === #
          "Mod+Home".focus-column-first = _:{};
          "Mod+End".focus-column-last = _:{};
          "Mod+Ctrl+Home".move-column-to-first = _:{};
          "Mod+Ctrl+End".move-column-to-last = _:{};

          # === Security === #
          "Mod+L".spawn-sh                      = lib.getExe pkgs.${userSettings.lockscreen}; #launches lockscreen
          "Mod+Shift+Q".quit                    = _:{};
          "Mod+O".spawn-sh                      = lib.getExe pkgs.opensnitch-ui;  #launches opensnitch

          # === Noctalia Binds === #
          "Mod+space".spawn-sh                  = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle"; #spawns the app launcher

          # === Monitor Navigation === #
          "Mod+Alt+Left".focus-monitor-left = _:{};
          "Mod+Alt+Right".focus-monitor-right = _:{};
          "Mod+Alt+Up".focus-monitor-up = _:{};
          "Mod+Alt+Down".focus-monitor-down = _:{};
          "Mod+Alt+H".focus-monitor-left = _:{};
          "Mod+Alt+J".focus-monitor-down = _:{};
          "Mod+Alt+K".focus-monitor-up = _:{};
          "Mod+Alt+L".focus-monitor-right = _:{};

          # === Move to Monitor === #
          "Mod+Alt+Ctrl+Left".move-column-to-monitor-left = _:{};
          "Mod+Alt+Ctrl+Down".move-column-to-monitor-down = _:{};
          "Mod+Alt+Ctrl+Up".move-column-to-monitor-up = _:{};
          "Mod+Alt+Ctrl+Right".move-column-to-monitor-right = _:{};
          "Mod+Alt+Ctrl+H".move-column-to-monitor-left = _:{};
          "Mod+Alt+Ctrl+J".move-column-to-monitor-down = _:{};
          "Mod+Alt+Ctrl+K".move-column-to-monitor-up = _:{};
          "Mod+Alt+Ctrl+L".move-column-to-monitor-right = _:{};

          # === Workspace Navigation === #
          "Mod+U".focus-workspace-down = _:{};
          "Mod+I".focus-workspace-up = _:{};
          "Mod+Page_Down".focus-workspace-down = _:{};
          "Mod+Page_Up".focus-workspace-up = _:{};
          "Mod+Ctrl+Page_Down".move-column-to-workspace-down = _:{};
          "Mod+Ctrl+Page_Up".move-column-to-workspace-up = _:{};

          # === Move Workspaces === #
          "Mod+Alt+Page_Down".move-workspace-down = _:{};
          "Mod+Alt+Page_Up".move-workspace-up = _:{};
          "Mod+Shift+U".move-workspace-down = _:{};
          "Mod+Shift+I".move-workspace-up = _:{};

          # === Mouse Wheel Navigation === #
          "Mod+WheelScrollDown".focus-workspace-down = _: {cooldown-ms=150;};
          "Mod+WheelScrollUp".focus-workspace-up = _: {cooldown-ms=150;};
          "Mod+Ctrl+WheelScrollDown".move-column-to-workspace-down = _: {cooldown-ms=150;};
          "Mod+Ctrl+WheelScrollUp".move-column-to-workspace-up = _: {cooldown-ms=150;};

          "Mod+WheelScrollRight".focus-column-right = _:{};
          "Mod+WheelScrollLeft".focus-column-left = _:{};
          "Mod+Ctrl+WheelScrollRight".move-column-right = _:{};
          "Mod+Ctrl+WheelScrollLeft".move-column-left = _:{};

          "Mod+Shift+WheelScrollDown".focus-column-right = _:{};
          "Mod+Shift+WheelScrollUp".focus-column-left = _:{};
          "Mod+Ctrl+Shift+WheelScrollDown".move-column-right = _:{};
          "Mod+Ctrl+Shift+WheelScrollUp".move-column-left = _:{};


          # === Numbered Workspaces === #
          "Mod+1".focus-workspace = 0;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+6".focus-workspace = 6;
          "Mod+7".focus-workspace = 7;
          "Mod+8".focus-workspace = 8;
          "Mod+9".focus-workspace = 9;

          # === Move to Numbered Workspaces === #
          "Mod+Ctrl+1".move-column-to-workspace = 1;
          "Mod+Ctrl+2".move-column-to-workspace = 2;
          "Mod+Ctrl+3".move-column-to-workspace = 3;
          "Mod+Ctrl+4".move-column-to-workspace = 4;
          "Mod+Ctrl+5".move-column-to-workspace = 5;
          "Mod+Ctrl+6".move-column-to-workspace = 6;
          "Mod+Ctrl+7".move-column-to-workspace = 7;
          "Mod+Ctrl+8".move-column-to-workspace = 8;
          "Mod+Ctrl+9".move-column-to-workspace = 9;

          # === Column Management === #
          "Mod+BracketLeft".consume-or-expel-window-left = _:{};
          "Mod+BracketRight".consume-or-expel-window-right = _:{};
          "Mod+Period".expel-window-from-column = _:{};


          # === Sizing & Layout === #
          "Mod+R".switch-preset-column-width = _:{};
          "Mod+Shift+R".switch-preset-window-height = _:{};
          "Mod+Ctrl+R".reset-window-height = _:{};
          "Mod+Ctrl+F".expand-column-to-available-width = _:{};
          "Mod+Ctrl+C".center-column = _:{};


          # === Manual Sizing === #
          "Mod+Minus".set-column-width = "-10%";
          "Mod+Equal".set-column-width = "+10%";
          "Mod+Shift+Minus".set-window-height = "-10%";
          "Mod+Shift+Equal".set-window-height = "+10%";


          # === Screenshots === #
          "Mod+Shift+S".screenshot = _:{};
          "XF86Launch1".screenshot = _:{};
          "Ctrl+XF86Launch1".screenshot-screen = _:{};
          "Alt+XF86Launch1".screenshot-window = _:{};
          "Print".screenshot = _:{};
          "Ctrl+Print".screenshot-screen = _:{};
          "Alt+Print".screenshot-window = _:{};

          # === Noctalia Config Sync === #
          #TODO make/fix a convienient config syncer
          #Ctrl+Shift+S {
          #spawn "sh" "-c" "/home/don/black-don-os/modules/home/noctalia-shell/sync-from-gui.py && notify-send 'Noctalia Config' 'Settings synced to Nix ' -i preferences-system";}

          # === System Controls === #
          "Mod+Alt+P".power-off-monitors = _:{};

          # === Custom Application Launchers === #
          "Mod+B".spawn-sh = "${userSettings.webBrowser}";
          "Mod+S".spawn = "${userSettings.fileBrowser}";

          "Mod+D".spawn-sh = "vesktop";
          "Ctrl+Mod+V".spawn = "virt-manager";
          "Ctrl+Mod+N".spawn = "obsidian";
          #"Ctrl+Mod+E"spawn "emopicker9000"; }
          #"Mod+Shift+Ctrl+C"pawn "${userSettings.terminal}" "claude"; }

          # === Color picker === #  TODO doesnt work
          "Mod+C".spawn-sh = "niri msg pick-color | grep 'Hex:' | cut -d' ' -f2 | wl-copy";

          "Mod+P".set-dynamic-cast-monitor = _:{};
          "Mod+Shift+P".set-dynamic-cast-window = _:{};
          "Mod+Ctrl+P".clear-dynamic-cast-target = _:{};

          # === Application Launchers === #
          "Mod+Y".spawn-sh = lib.getExe pkgs.fuzzel;
        };
      };
    };
  };
}
