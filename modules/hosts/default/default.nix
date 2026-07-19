{ self, inputs, ... }: {
  flake.nixosConfigurations.defaultConfig = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.machineConfig
    ];
  };
}