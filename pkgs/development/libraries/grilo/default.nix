{ lib, stdenv, fetchurl, fetchpatch, meson, ninja, pkg-config, gettext, vala, glib, liboauth, gtk3
, gtk-doc, docbook_xsl, docbook_xml_dtd_43
, libxml2, gnome, gobject-introspection, libsoup, totem-pl-parser }:

stdenv.mkDerivation rec {
  pname = "grilo";
  version = "0.3.14"; # if you change minor, also change ./setup-hook.sh

  outputs = [ "out" "dev" "man" "devdoc" ];
  outputBin = "dev";

  setupHook = ./setup-hook.sh;

  src = fetchurl {
    url = "mirror://gnome/sources/${pname}/${lib.versions.majorMinor version}/${pname}-${version}.tar.xz";
    sha256 = "A2nQsAuw9Zul966oz8Zl843xSltBgtKMfB4s0VtRh0M=";
  };

  patches = [
    (fetchpatch {
      name = "CVE-2021-39365.patch";
      url = "https://gitlab.gnome.org/GNOME/grilo/-/commit/cd2472e506dafb1bb8ae510e34ad4797f63e263e.patch";
      sha256 = "1i1p21vlms43iawg4dl1dibnpsbnkx27kcfvllnx76q07bfrpwzm";
    })
  ];

  setupHook = ./setup-hook.sh;

  mesonFlags = [
    "-Denable-gtk-doc=true"
  ];

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    gettext
    gobject-introspection
    vala
    gtk-doc
    docbook-xsl-nons
    docbook_xml_dtd_43
  ];

  buildInputs = [
    glib
    liboauth
    gtk3
    libxml2
    libsoup
    totem-pl-parser
  ];

  passthru = {
    updateScript = gnome.updateScript {
      packageName = pname;
      versionPolicy = "none";
    };
  };

  meta = with lib; {
    homepage = "https://wiki.gnome.org/Projects/Grilo";
    description = "Framework that provides access to various sources of multimedia content, using a pluggable system";
    maintainers = teams.gnome.members;
    license = licenses.lgpl2Plus;
    platforms = platforms.linux;
  };
}
