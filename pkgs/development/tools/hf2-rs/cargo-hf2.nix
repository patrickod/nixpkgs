{ stdenv,
  fetchFromGitHub,
  rustPlatform,
  lib
}:

rustPlatform.buildRustPackage rec {
  pname = "cargo-hf2";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "jacobbrosenthal";
    repo = "hf2-rs";
    rev = "v${version}";
    sha256 = "0l7yvpc59mbzh87lngj6pj8w586fwa07829l5x9mmxnkf6srapmc";
  };

  source = "source/hf2-cli";

  cargoSha256 = "1gwv6slbfm4f8m9slzsxlaapiw51gssaz3vjnnl47jcaaq3g8hvq";

  meta = with stdenv.lib; {
    description = "Replaces the cargo build command to include flashing over USB to UF2 devices";
    homepage = "https://github.com/jacobbrosenthal/hf2-rs";
    licenses = licenses.mit;
    maintainers = with maintainers; [ patrickod ];
    platforms = platforms.all;
  };

}
