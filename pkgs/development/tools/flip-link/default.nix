{ lib, rustPlatform, fetchFromGitHub, libusb1, pkgconfig, glib, dbus, rustfmt }:
rustPlatform.buildRustPackage rec {
  pname = "flip-link";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "knurling-rs";
    repo = "flip-link";
    rev = "v${version}";
    sha256 = "1wdgrlm7jg7bsc4lnqbsp4rx6s52k587lb7ygqkqzn2f9fp9ywbq";
  };

  nativeBuildInputs = [pkgconfig rustfmt];
  cargoSha256 = "1khpk80rp2f2383cxjk8cjj58zj1p1kx2j547qhn8fgdaz8j9lap";

  meta = with lib; {
    description = "adds zero-cost stack overflow protection to your embedded programs";
    homepage = "https://github.com/knurling-rs/flip-link";
    license = licenses.mit;
    maintainers = with maintainers; [ patrickod ];
  };
}

