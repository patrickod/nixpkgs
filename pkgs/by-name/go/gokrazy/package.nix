{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "gokrazy";
  version = "0-unstable-2025-05-31";

  src = fetchFromGitHub {
    owner = "gokrazy";
    repo = "tools";
    rev = "2e390edb1234ee5c32b9e05d2ec04c593b512925";
    hash = "sha256-GcF55cgU3hMVkzwLVw3gFrBAkumbp551+s+FjvLbCgI=";
  };

  vendorHash = "sha256-BBiRkOYKiiq8OZnmGwHqjseNIhyokqzyURY6npI8v4Q=";

  ldflags = [
    "-s"
    "-w"
    "-X=main.Version=${version}"
  ];

  subPackages = [ "cmd/gok" ];

  meta = with lib; {
    description = "Turn your Go program(s) into an appliance running on the Raspberry Pi 3, Pi 4, Pi Zero 2 W, or amd64 PCs!";
    homepage = "https://github.com/gokrazy/gokrazy";
    license = licenses.bsd3;
    maintainers = with maintainers; [ shayne ];
    mainProgram = "gok";
  };
}
