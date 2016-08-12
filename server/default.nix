{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc7103" }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, aeson, base, monad-logger, mtl, persistent
      , persistent-postgresql, persistent-template, servant-server
      , stdenv, wai, warp
      }:
      mkDerivation {
        pname = "server";
        version = "0.1.0.0";
        src = ./.;
        isLibrary = true;
        isExecutable = true;
        libraryHaskellDepends = [
          aeson base mtl persistent persistent-postgresql persistent-template
          servant-server wai warp
        ];
        executableHaskellDepends = [
          base monad-logger persistent-postgresql warp
        ];
        testHaskellDepends = [ base ];
        homepage = "https://github.com/mckeankylej/server#readme";
        description = "Initial project template from stack";
        license = stdenv.lib.licenses.bsd3;
      };

  haskellPackages = pkgs.haskell.packages.${compiler};

  drv = haskellPackages.callPackage f {};

in

  if pkgs.lib.inNixShell then drv.env else drv
