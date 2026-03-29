{host, ...}: let
  inherit
    (import ../../../../hosts/${host}/variables.nix)
    browser
    terminal
    ;
in {
  # Host-specific binds for Framework
  # These will be merged with the default binds
  bind = [
    # Add host-specific keybinds here
  ];

  bindm = [
    # Add host-specific mouse binds here
  ];
}
