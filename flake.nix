{
  description = "MRE for option-types issue";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  outputs =
    { nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;
    in
    {
      legacyPackages = lib.mapAttrs (
        system: pkgs: import ./. { inherit pkgs lib; }
      ) nixpkgs.legacyPackages;

      result = import ./. { inherit lib; };

      inherit lib;
    };
}
