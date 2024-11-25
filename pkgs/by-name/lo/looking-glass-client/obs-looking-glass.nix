# We don't have a wrapper which can supply obs-studio plugins so you have to
# somewhat manually install this:

# nix-env -f "<nixpkgs>" -iA obs-looking-glass
# mkdir -p ~/.config/obs-studio/plugins/looking-glass/bin/64bit
# ln -s ~/.nix-profile/share/obs/obs-plugins/looking-glass-obs ~/.config/obs-studio/plugins/looking-glass/bin/64bit/

{ stdenv, fetchFromGitHub, cmake, pkgconfig, SDL2, SDL, SDL2_ttf, openssl,
spice-protocol, fontconfig , libX11, freefont_ttf, nettle, libconfig, wayland,
libpthreadstubs, libXdmcp, libXfixes, libbfd, libXi, obs-studio }:

stdenv.mkDerivation rec {
  pname = "obs-looking-glass";
  version = "B2-rc2";

  src = fetchFromGitHub {
    owner = "gnif";
    repo = "LookingGlass";
    rev = version;
    sha256 = "0xcnvn7b621sxzld53csrm257agz5bizxl4bnjqwx8djpj0yhv6x";
    fetchSubmodules = true;
  };
  sourceRoot = "source/obs";

  buildInputs = [
    SDL SDL2 SDL2_ttf openssl spice-protocol fontconfig
    libX11 freefont_ttf nettle libconfig wayland libpthreadstubs
    libXdmcp libXfixes libbfd cmake libXi obs-studio
  ];

  cmakeFlags = [
    "-DLIBOBS_LIB=${obs-studio}/lib"
  ];

  installPhase = ''
    mkdir -p $out/share/obs/obs-plugins
    cp -r liblooking-glass-obs.so $out/share/obs/obs-plugins/looking-glass-obs
  '';

  meta = with stdenv.lib; {
    description = "Looking Glass Plugin for OBS Studio";
    homepage = "https://github.com/ngif/LookingGlass";
    maintainers = [ maintainers.alexbakker ];
    license = licenses.gpl2;
    platforms = with platforms; linux;
  };
}
