{ lib, stdenv, fetchurl, nixosTests }:

let
  generic = {
    version, sha256,
    eol ? false, extraVulnerabilities ? []
  }: stdenv.mkDerivation rec {
    pname = "nextcloud";
    inherit version;

    src = fetchurl {
      url = "https://download.nextcloud.com/server/releases/${pname}-${version}.tar.bz2";
      inherit sha256;
    };

    passthru.tests = nixosTests.nextcloud;

    installPhase = ''
      runHook preInstall
      mkdir -p $out/
      cp -R . $out/
      runHook postInstall
    '';

    meta = with lib; {
      description = "Sharing solution for files, calendars, contacts and more";
      homepage = "https://nextcloud.com";
      maintainers = with maintainers; [ schneefux bachp globin fpletz ma27 ];
      license = licenses.agpl3Plus;
      platforms = with platforms; unix;
      knownVulnerabilities = extraVulnerabilities
        ++ (optional eol "Nextcloud version ${version} is EOL");
    };
  };
in {
  nextcloud20 = throw ''
    Nextcloud v20 has been removed from `nixpkgs` as the support for it was dropped
    by upstream in 2021-10. Please upgrade to at least Nextcloud v21 by declaring

        services.nextcloud.package = pkgs.nextcloud21;

    in your NixOS config.

    WARNING: if you were on Nextcloud 19 on NixOS 21.05 you have to upgrade to Nextcloud 20
    first on 21.05 because Nextcloud doesn't support upgrades accross multiple major versions!
  '';

  nextcloud19 = generic {
    version = "19.0.13";
    sha256 = "sha256-pc5sS7cK65c5vwG7NhKaWU2DeXHovSHH0wEmeosxIg8=";
    extraVulnerabilities = [
      "Nextcloud 19 is still supported, but CVE-2020-8259 & CVE-2020-8152 are unfixed! Please note that both CVEs only affect the file encryption module which is turned off by default. Alternatively, `pkgs.nextcloud20` can be used."
      "Nextcloud 19 is EOL!"
    ];
  };

  nextcloud20 = generic {
    version = "20.0.13";
    sha256 = "15mi51aayi3m8brxc0w51mbxp4h3hjv14gr5mm7ch2930x655gg9";
  };

  nextcloud21 = generic {
    version = "21.0.5";
    sha256 = "1q46h480kn97k7h3xm7r5gsa8l3f0kfiicapi46sh0p39pbjbyhv";
  };

  nextcloud22 = generic {
    version = "22.2.2";
    sha256 = "sha256-lDvn29N19Lhm3P2YIVM/85vr/U07qR+M8TkF/D/GTfA=";
  };
  # tip: get she sha with:
  # curl 'https://download.nextcloud.com/server/releases/nextcloud-${version}.tar.bz2.sha256'
}
