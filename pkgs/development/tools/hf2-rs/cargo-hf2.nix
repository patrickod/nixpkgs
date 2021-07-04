{ stdenv,
  fetchFromGitHub,
  rustPlatform,
  lib,
  pkgconfig,
  libusb
}:

rustPlatform.buildRustPackage rec {
  pname = "cargo-hf2";
  version = "0.3.1";

  src = fetchFromGitHub {
    owner = "jacobrosenthal";
    repo = "hf2-rs";
    rev = "v${version}";
    sha256 = "0hjlhic0yffh5dd4zagjl4ywhqf48py2yjf736r507x9wi8072hn";
  };

  source = "source/cargo-hf2";
  cargoPatches = [
    ./cargo-lock.patch
  ];
  cargoSha256 = "048cih3pa24pyabnk018nhfmw9nl9n37k9rl9b16pwkj1x108a03";
  nativeBuildInputs = [pkgconfig];
  buildInputs = [libusb];

  meta = with lib; {
    description = "Replaces the cargo build command to include flashing over USB to UF2 devices";
    homepage = "https://github.com/jacobbrosenthal/hf2-rs";
    licenses = licenses.mit;
    maintainers = with maintainers; [ patrickod ];
    platforms = platforms.all;
    inherit version;
  };

}
