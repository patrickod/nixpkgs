{ buildPackages, callPackage, stdenv }@prev:

{ rustc, cargo, stdenv ? prev.stdenv, ... }:

rec {
  rust = {
    inherit rustc cargo;
  };

  fetchCargoTarball = buildPackages.callPackage ../../../build-support/rust/fetch-cargo-tarball {
    inherit cargo;
  };

  buildRustPackage = callPackage ../../../build-support/rust/build-rust-package {
    inherit cargoBuildHook cargoCheckHook cargoInstallHook cargoSetupHook
      fetchCargoTarball rustc;
  };

  importCargoLock = buildPackages.callPackage ../../../build-support/rust/import-cargo-lock.nix {};

  rustcSrc = callPackage ./rust-src.nix {
    inherit stdenv rustc;
  };

  rustLibSrc = callPackage ./rust-lib-src.nix {
    inherit stdenv rustc;
  };

  # Hooks
  inherit (callPackage ../../../build-support/rust/hooks {
    inherit stdenv cargo rustc;
  }) cargoBuildHook cargoCheckHook cargoInstallHook cargoSetupHook maturinBuildHook;
}
