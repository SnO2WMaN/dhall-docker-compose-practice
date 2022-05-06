{
  description = "dhall with docker-compose";
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };
  outputs = { self, nixpkgs, nixops-plugged, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system: {
        devShell =
          let pkgs = import nixpkgs {
            inherit system;
            overlays = [ devshell.overlay ];
          };
          in
          pkgs.devshell.mkShell {
            imports = [ (pkgs.devshell.importTOML ./devshell.toml) ];
          };
      }
    );
}
