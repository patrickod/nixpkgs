{ lib, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "dotenv";
  version = "0.15.0";

  src = fetchFromGitHub {
    owner = "dotenv-rs";
    repo = pname;
    rev = "v${version}";
    sha256 = "0xx2j4ycfrgq2rkdh3zikkhayhxhqsmq42haxwwimi29qdikqblc";
  };

  cargoPatches = [
    ./cargo.lock.patch

  ];

  cargoSha256 ="0vj9xdjbwhr0crv1bvzabdq5hmixbfdbq6ykiv7wq3vj4zqkiii3";

  meta = with lib; {
    description = "dotenv loads enviroment variables from .env files";
    homepage = "https://github.com/dotenv-rs/dotenv";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ patrickod ];
  };
}

