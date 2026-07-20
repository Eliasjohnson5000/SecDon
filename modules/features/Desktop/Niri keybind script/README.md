This Script takes the keybind syntax for Niri inside of Home Manager and converts it to the module syntax that can be found in "~/SecDonDed/modules/features/niri.nix"

WARNING: this script is not extensive and will not work for all applications.

1) put the input into the input file

2) run the script

3) check the output file

Example:

``` 
Mod+Home { focus-column-first; }
Mod+End  { focus-column-last; }
Mod+Ctrl+Home { move-column-to-first; }
Mod+Ctrl+End  { move-column-to-last; };
```

to 

```
"Mod+Home".focus-column-first = _:{};
"Mod+End".focus-column-last = _:{};
"Mod+Ctrl+Home".move-column-to-first = _:{};
"Mod+Ctrl+End".move-column-to-last = _:{};
```
