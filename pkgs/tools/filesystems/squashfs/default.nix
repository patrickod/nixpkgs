{ lib
, stdenv
, fetchFromGitHub
, fetchpatch
, zlib
, xz
, lz4
, lzo
, zstd
, nixosTests
}:

stdenv.mkDerivation rec {
  pname = "squashfs";
  version = "4.5";

  src = fetchFromGitHub {
    owner = "plougher";
    repo = "squashfs-tools";
    rev = version;
    sha256 = "1nanwz5qvsakxfm37md5i7xqagv69nfik9hpj8qlp6ymw266vgxr";
  };

  patches = [
    # This patch adds an option to pad filesystems (increasing size) in
    # exchange for better chunking / binary diff calculation.
    ./4k-align.patch
    # Add -no-hardlinks option. This is a rebased version of
    # c37bb4da4a5fa8c1cf114237ba364692dd522262, can be removed
    # when upgrading to the next version after 4.4
    ./0001-Mksquashfs-add-no-hardlinks-option.patch
    (fetchpatch {
      name = "CVE-2021-40153.patch";
      url = "https://github.com/plougher/squashfs-tools/commit/79b5a555058eef4e1e7ff220c344d39f8cd09646.patch";
      excludes = [ "squashfs-tools/unsquashfs.c" ];
      sha256 = "1sqc076a2dp8w4pfpdmak0xy4ic364ln2ayngcbp5mp3k3jl3rlr";
    })
  ] ++ lib.optional stdenv.isDarwin ./darwin.patch;

  buildInputs = [ zlib xz zstd lz4 lzo ];

  preBuild = ''
    cd squashfs-tools
  '' ;

  installFlags = [ "INSTALL_DIR=${placeholder "out"}/bin" ];

  makeFlags = [
    "XZ_SUPPORT=1"
    "ZSTD_SUPPORT=1"
    "LZ4_SUPPORT=1"
    "LZO_SUPPORT=1"
  ];

  passthru.tests = {
    nixos-iso-boots-and-verifies = nixosTests.boot.biosCdrom;
  };

  meta = with lib; {
    homepage = "https://github.com/plougher/squashfs-tools";
    description = "Tool for creating and unpacking squashfs filesystems";
    platforms = platforms.unix;
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ ruuda ];
  };
}
