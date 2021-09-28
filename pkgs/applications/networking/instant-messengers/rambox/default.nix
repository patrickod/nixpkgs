{ stdenv, callPackage, fetchurl, lib }:

let
  mkRambox = opts: callPackage (import ./rambox.nix opts) { };
in mkRambox rec {
  pname = "rambox";
  version = "0.7.8";

  src = {
    x86_64-linux = fetchurl {
      url = "https://github.com/ramboxapp/community-edition/releases/download/${version}/Rambox-${version}-linux-x86_64.AppImage";
      sha256 = "1y3c9xh8594ay95rj9vaqxxzibwpc38n7ixxi2wnsrdbrqrwlc63";
    };
    i686-linux = fetchurl {
      url = "https://github.com/ramboxapp/community-edition/releases/download/${version}/Rambox-${version}-linux-i386.AppImage";
      sha256 = "07sv384nd2i701fkjgsrlib8jfsa01bvj60gnqdwlnpphlknga3h";
    };
  }.${stdenv.system} or (throw "Unsupported system: ${stdenv.system}");

  meta = with lib; {
    description = "Free and Open Source messaging and emailing app that combines common web applications into one";
    homepage = "https://rambox.pro";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = ["i686-linux" "x86_64-linux"];
    hydraPlatforms = [];
    knownVulnerabilities = [
      "Electron 7.2.4 is EOL and contains at least the following vulnerabilities: CVE-2020-6458, CVE-2020-6460 and more (https://www.electronjs.org/releases/stable?version=7). Consider using an alternative such as `ferdi'."
    ];
  };
}
