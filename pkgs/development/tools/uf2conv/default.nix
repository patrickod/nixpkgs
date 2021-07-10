{ lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "uf2conv";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "sajattack";
    repo = "uf2conv-rs";
    rev = "v${version}";
    sha256 = "0g0rh2hcjvri4mfrf7lrayzka4pr165450qbaxg7p5292cbxlar1";
  };

  cargoSha256 = "0y4m6jm7nws2nynkrj13ap5ns9abl55dc2b763wkz9q7z9l0mj8b";
  cargoPatches = [./cargo-lock.patch];

  meta = with lib; {
    description = "Converts binary files to Microsoft's UF2 format";
    homepage = "https://github.com/sajattack/uf2conv-rs";
    licenses = licenses.mit;
    maintainers = with maintainers; [ patrickod ];
    platforms = platforms.all;
    inherit version;
  };

}
