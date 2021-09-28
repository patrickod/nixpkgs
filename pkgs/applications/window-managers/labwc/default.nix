{ lib
, stdenv
, fetchFromGitHub
, fetchpatch
, pkg-config
, meson
, ninja
, cairo
, glib
, libinput
, libxml2
, pango
, wayland
, wayland-protocols
, wlroots
, libxcb
, libxkbcommon
, xwayland
, libdrm
, scdoc
}:

stdenv.mkDerivation rec {
  pname = "labwc";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "johanmalm";
    repo = pname;
    rev = version;
    sha256 = "sha256-v8LGiQG/n1IXeVMPWyiP9MgZzZLW78JftvxnRVTswaM=";
  };

  patches = [
    # To fix the build with wlroots 0.14:
    (fetchpatch {
      # output: access texture width/height directly
      url = "https://github.com/johanmalm/labwc/commit/892e93dd84c514b4e6f34a0fab01c727edd2d8de.patch";
      sha256 = "1p1pg1kd98727wlcspa2sffl7ijhvsfad6bj2rxsw322q0bz3yrh";
    })
  ];

  nativeBuildInputs = [ pkg-config meson ninja scdoc ];
  buildInputs = [
    cairo
    glib
    libdrm
    libinput
    libxcb
    libxkbcommon
    libxml2
    pango
    wayland
    wayland-protocols
    wlroots
    xwayland
  ];

  mesonFlags = [ "-Dxwayland=enabled" ];

  meta = with lib; {
    homepage = "https://github.com/johanmalm/labwc";
    description = "Openbox alternative for Wayland";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ AndersonTorres ];
    platforms = platforms.unix;
  };
}
