{
  pkgs ? import <nixpkgs> { },
  lib ? pkgs.lib,
}:
rec {
  basic-type = lib.types.str;
  basic-type' = basic-type // {
    # Append ' to all values before merging
    merge =
      loc: defs: basic-type.merge loc (builtins.map (def: def // { value = def.value + "'"; }) defs);
  };

  comp-type = lib.types.attrsOf basic-type;
  comp-type' = lib.types.attrsOf basic-type';

  module = {
    options = {
      basic = lib.mkOption {
        type = basic-type;
      };
      basic' = lib.mkOption {
        type = basic-type';
      };
      comp = lib.mkOption {
        type = comp-type;
      };
      comp' = lib.mkOption {
        type = comp-type';
      };
    };
  };

  configuration = lib.evalModules {
    modules = [ module ];
  };
}
