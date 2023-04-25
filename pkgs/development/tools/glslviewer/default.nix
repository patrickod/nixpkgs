{ lib
, stdenv
, fetchFromGitHub
, libXrandr
, libXext
, libXinerama
, libXcursor
, libXi
, libX11
, libGLU
, Cocoa
, cmake
, ninja
, ffmpeg
, ncurses5
}:

stdenv.mkDerivation rec {
  pname = "glslviewer";
  version = "3.2.2";

  src = fetchFromGitHub {
    owner = "patriciogonzalezvivo";
    repo = "glslViewer";
    rev = version;
    sha256 = "sha256-R8B7f4pjiWqRjx12832lrMZkfiwDwkCwhC0zTdyLOpo=";
    fetchSubmodules = true;
  };


  nativeBuildInputs = [ cmake ninja ];
  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE='Release'"
    "-GNinja"
  ];

  buildInputs = [
    libX11
    libXrandr
    libXinerama
    libXcursor
    libXi
    libXext
    libGLU
    ffmpeg
    ncurses5
  ]
  ++ lib.optional stdenv.isDarwin Cocoa;

  meta = with lib; {
    description = "Live GLSL coding renderer";
    homepage = "https://patriciogonzalezvivo.com/2015/glslViewer/";
    license = licenses.bsd3;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = [ maintainers.hodapp ];
    # never built on aarch64-darwin since first introduction in nixpkgs
    broken = stdenv.isDarwin && stdenv.isAarch64;
  };
}
