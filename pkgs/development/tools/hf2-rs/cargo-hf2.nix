{ stdenv,
  fetchFromGitHub,
  rustPlatform,
  lib,
  pkgconfig,
  libusb
}:

rustPlatform.buildRustPackage rec {
  pname = "cargo-hf2";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "jacobrosenthal";
    repo = "hf2-rs";
    rev = "v${version}";
    sha256 = "0z4vf6w29zy4ip8s8fnx33vly0a79wfg8ifqlznbnh4y69gxm9qy";
  };

  source = "source/cargo-hf2";

  cargoPatches = [
    ./cargo-lock.patch
  ];
  cargoSha256 = "15vg9n31kw4vyz7qfn9myfdjgagrafcpyjf1nv2xaz6a146id3xz";

  nativeBuildInputs = [pkgconfig];
  buildInputs = [libusb];

  meta = with stdenv.lib; {
    description = "Replaces the cargo build command to include flashing over USB to UF2 devices";
    homepage = "https://github.com/jacobbrosenthal/hf2-rs";
    licenses = licenses.mit;
    maintainers = with maintainers; [ patrickod ];
    platforms = platforms.all;
    inherit version;
  };

}
