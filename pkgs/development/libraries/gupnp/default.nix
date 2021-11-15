{ stdenv
, lib
, fetchurl
, fetchpatch
, meson
, ninja
, pkg-config
, gobject-introspection
, vala
, gtk-doc
, docbook_xsl
, docbook_xml_dtd_412
, docbook_xml_dtd_44
, glib
, gssdp
, libsoup
, libxml2
, libuuid
, gnome
}:

stdenv.mkDerivation rec {
  pname = "gupnp";
  version = "1.4.0";

  outputs = [ "out" "dev" "devdoc" ];

  src = fetchurl {
    url = "mirror://gnome/sources/gupnp/${lib.versions.majorMinor version}/${pname}-${version}.tar.xz";
    sha256 = "sha256-WQ/7ArhNoqGuxo/VNLxArxs33T9iI/nRV3/EirSL428=";
  };

  patches = [
    (fetchpatch {
      name = "CVE-2021-33516.patch";
      url = "https://gitlab.gnome.org/GNOME/gupnp/-/commit/ca6ec9dcb26fd7a2a630eb6a68118659b589afac.patch";
      sha256 = "sha256-G7e/xNQB7Kp2fPzqVeD/cH3h1co9hZXh55QOUBnAnvU=";
    })
  ];

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    gobject-introspection
    vala
    gtk-doc
    docbook_xsl
    docbook_xml_dtd_412
    docbook_xml_dtd_44
  ];

  buildInputs = [
    libuuid
  ];

  propagatedBuildInputs = [
    glib
    gssdp
    libsoup
    libxml2
  ];

  mesonFlags = [
    "-Dgtk_doc=true"
  ];

  doCheck = true;

  passthru = {
    updateScript = gnome.updateScript {
      packageName = pname;
    };
  };

  meta = with lib; {
    homepage = "http://www.gupnp.org/";
    description = "An implementation of the UPnP specification";
    license = licenses.lgpl2Plus;
    platforms = platforms.linux;
  };
}
