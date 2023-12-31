{
  description = "Flight Price Prediction";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in rec {
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          (python311.withPackages(ps: with ps; [
            nbdime
            ipython
            jupyter
            numpy
            pandas
            scipy
            matplotlib
            seaborn
          ]))
        ];

        shellHook = ''
          nbdime config-git --enable
        '';
      };
    }
  );
}
