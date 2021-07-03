{ lib, stdenv, fetchFromGitHub
, pkg-config, libftdi1
, python3, pypy3

# PyPy yields large improvements in build time and runtime performance, and
# IceStorm isn't intended to be used as a library other than by the nextpnr
# build process (which is also sped up by using PyPy), so we use it by default.
# See 18839e1 for more details.
#
# FIXME(aseipp, 3/1/2021): pypy seems a bit busted since stdenv upgrade to gcc
# 10/binutils 2.34, so short-circuit this for now in passthru below (done so
# that downstream overrides can't re-enable pypy and break their build somehow)
, usePyPy ? stdenv.hostPlatform.system == "x86_64-linux"
}:

stdenv.mkDerivation rec {
  pname = "icestorm";
  version = "2021.07.03";

  passthru = rec {
    pythonPkg = if (false && usePyPy) then pypy3 else python3;
    pythonInterp = pythonPkg.interpreter;
  };

  src = fetchFromGitHub {
    owner  = "YosysHQ";
    repo   = "icestorm";
    rev    = "c495861c19bd0976c88d4964f912abe76f3901c3";
    sha256 = "1r98scq08kk5lspz53makagjac8f0scmrjyns13srz6z39bq46vw";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ passthru.pythonPkg libftdi1 ];
  makeFlags = [ "PREFIX=$(out)" ];

  enableParallelBuilding = true;

  # fix icebox_vlog chipdb path. icestorm issue:
  #   https://github.com/cliffordwolf/icestorm/issues/125
  #
  # also, fix up the path to the chosen Python interpreter. for pypy-compatible
  # platforms, it offers significant performance improvements.
  patchPhase = ''
    substituteInPlace ./icebox/icebox_vlog.py \
      --replace /usr/local/share "$out/share"

    for x in icefuzz/Makefile icebox/Makefile icetime/Makefile; do
      substituteInPlace "$x" --replace python3 "${passthru.pythonInterp}"
    done

    for x in $(find . -type f -iname '*.py'); do
      substituteInPlace "$x" \
        --replace '/usr/bin/env python3' '${passthru.pythonInterp}'
    done
  '';

  meta = {
    description = "Documentation and tools for Lattice iCE40 FPGAs";
    longDescription = ''
      Project IceStorm aims at reverse engineering and
      documenting the bitstream format of Lattice iCE40
      FPGAs and providing simple tools for analyzing and
      creating bitstream files.
    '';
    homepage    = "http://www.clifford.at/icestorm/";
    license     = lib.licenses.isc;
    maintainers = with lib.maintainers; [ shell thoughtpolice emily ];
    platforms   = lib.platforms.all;
  };
}
