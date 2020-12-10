{ lib, rustPlatform, fetchFromGitHub, libusb1, pkgconfig, glib, dbus, rustfmt }:
rustPlatform.buildRustPackage rec {
  pname = "probe-run";
  version = "0.1.7";

  src = fetchFromGitHub {
    owner = "knurling-rs";
    repo = "probe-run";
    rev = "v${version}";
    sha256 = "17qm5vjyvjk3zbimlvgqnwjj9qqnzkqj124z12m5kgnmlqykygfc";
  };

  nativeBuildInputs = [pkgconfig rustfmt];
  buildInputs = [
      dbus
      glib
      libusb1
    ];

  cargoSha256 = "0cxgp3ifn0lhqq4rpikma1v6c074zlz53wqa55z7q5lys2d5ajq4";
  cargoBuildFlags = ["--features=defmt"];

  meta = with lib; {
    description = "a custom Cargo runner that transparently runs Rust firmware on a remote device";
    homepage = "https://github.com/knurling-rs/probe-run";
    license = licenses.mit;
    maintainers = with maintainers; [ patrickod ];
  };
}
