{ mkDerivation, fetchFromGitHub, extra-cmake-modules, lib, libpulseaudio, git, flac,
  qtbase, qtquickcontrols2, qtgraphicaleffects, libxcb
}:

mkDerivation rec {
  pname = "noson";
  version = "4.4.2";

  src = fetchFromGitHub {
    owner = "janbar";
    repo = "noson-app";
    rev = "${version}";
    sha256 = "0annp87sdcb5sq9ywivm1wmrnx2751dv0rdxdrg42yip4cnsr4jv";
  };

  dontWrapQtApps = true;
  preFixup = ''
    for f in noson-gui noson-cli; do
      wrapQtApp $out/lib/noson/$f
    done
  '';

  nativeBuildInputs = [ extra-cmake-modules git ];

  propagatedBuildInputs = [ libpulseaudio flac qtbase qtquickcontrols2 qtgraphicaleffects libxcb ];

  meta = with lib; {
    homepage = "https://github.com/janbar/noson-app";
    description = "A fast and smart SONOS controller for Linux platforms";
    license = licenses.gpl3;
    maintainers = with maintainers; [ patrickod ];
  };
}
