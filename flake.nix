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
    };
  };
  outputs = { self, nixpkgs, devshell, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system: {
        devShell =
          let pkgs = import nixpkgs {
            inherit system;
            overlays = [
              devshell.overlay
              (final: prev: {
                taplo-cli = prev.taplo-cli.overrideAttrs (old: rec { version = "0.6.2"; });
              })
            ];
          };
          in
          pkgs.devshell.mkShell {
            imports = [
              (pkgs.devshell.importTOML ./devshell.toml)
            ];
          };
      }
    );
}
