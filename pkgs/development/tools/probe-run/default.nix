{ lib, rustPlatform, fetchFromGitHub, libusb1, pkgconfig, glib, dbus, rustfmt }:
rustPlatform.buildRustPackage rec {
  pname = "probe-run";
  version = "main";

  src = fetchFromGitHub {
    owner = "knurling-rs";
    repo = "probe-run";
    rev = "${version}";
    sha256 = "026c53cgcrfhr31n2zzdgik9cr1j7fk4x9r5q82ph66qbqvyvkkj";
  };

  nativeBuildInputs = [pkgconfig rustfmt];
  buildInputs = [
      dbus
      glib
      libusb1
    ];

  cargoSha256 = "0whazdc22vw076p1fsl2qfs81kq3zpvr2jyxz27799zifzzk812m";
  cargoBuildFlags = ["--features=defmt"];

  meta = with lib; {
    description = "a custom Cargo runner that transparently runs Rust firmware on a remote device";
    homepage = "https://github.com/knurling-rs/probe-run";
    license = licenses.mit;
    maintainers = with maintainers; [ patrickod ];
  };
}

