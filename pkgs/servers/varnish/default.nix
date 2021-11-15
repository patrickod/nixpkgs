{ lib, stdenv, fetchurl, fetchpatch, pcre, pcre2, libxslt, groff, ncurses, pkg-config, readline, libedit, coreutils
, python3, makeWrapper }:

let
  common = { version, sha256, extraNativeBuildInputs ? [], extraPatches ? [] }:
    stdenv.mkDerivation rec {
      pname = "varnish";
      inherit version;

      src = fetchurl {
        url = "https://varnish-cache.org/_downloads/${pname}-${version}.tgz";
        inherit sha256;
      };

      patches = extraPatches;

      passthru.python = python3;

      nativeBuildInputs = with python3.pkgs; [ pkg-config docutils sphinx ];
      buildInputs = [
        libxslt groff ncurses readline libedit makeWrapper python3
      ]
      ++ lib.optional (lib.versionOlder version "7") pcre
      ++ lib.optional (lib.versionAtLeast version "7") pcre2;

      buildFlags = [ "localstatedir=/var/spool" ];

      postPatch = ''
        substituteInPlace bin/varnishtest/vtc_main.c --replace /bin/rm "${coreutils}/bin/rm"
      '';

      postInstall = ''
        wrapProgram "$out/sbin/varnishd" --prefix PATH : "${lib.makeBinPath [ stdenv.cc ]}"
      '';

      # https://github.com/varnishcache/varnish-cache/issues/1875
      NIX_CFLAGS_COMPILE = lib.optionalString stdenv.isi686 "-fexcess-precision=standard";

      outputs = [ "out" "dev" "man" ];

      meta = with lib; {
        description = "Web application accelerator also known as a caching HTTP reverse proxy";
        homepage = "https://www.varnish-cache.org";
        license = licenses.bsd2;
        maintainers = with maintainers; [ fpletz ];
        platforms = platforms.unix;
      };
    };
in
{
  varnish60 = common {
    version = "6.0.8";
    sha256 = "1zk83hfxgjq1d0n4zx86q3f05y9f2zc6a1miz1zcvfa052q4bljx";
  };
  varnish62 = common {
    version = "6.2.3";
    sha256 = "02b6pqh5j1d4n362n42q42bfjzjrngd6x49b13q7wzsy6igd1jsy";
    extraPatches = [
      ./6.2-6.3-CVE-2021-36740.patch
    ];
  };
  varnish63 = common {
    version = "6.3.2";
    sha256 = "1f5ahzdh3am6fij5jhiybv3knwl11rhc5r3ig1ybzw55ai7788q8";
    extraPatches = [
      ./6.2-6.3-CVE-2021-36740.patch
    ];
  };
  varnish70 = (common {
    version = "7.0.0";
    sha256 = "11z0pa618lh925ih67wmp1gqk7i46l486j4spjy71g1n3w5mqylc";
  }).overrideAttrs (oA: {
    patches = [
      (fetchpatch {
        url = "https://github.com/varnishcache/varnish-cache/commit/20e007a5b17c1f68f70ab42080de384f9e192900.patch";
        sha256 = "0vvihbjknb0skdv2ksn2lz89pwmn4f2rjmb6q65cvgnnjfj46s82";
      })
    ];
  });
}
