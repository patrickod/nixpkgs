{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  pname = "flyctl";
  version = "0.0.285";

  src = fetchFromGitHub {
    owner = "superfly";
    repo = "flyctl";
    rev = "v${version}";
    sha256 = "sha256-0MXIZbD/Vj2dGcepzPk7mMLZQQwDQHQS3WVjd+b4flY=";
  };

  preBuild = ''
    go generate ./...
  '';

  subPackages = [ "." ];

  vendorSha256 = "sha256-OJGfYXiI1K63N9DkPkp7rawg8f8dgnJQNHfp6nDU4LM=";

  doCheck = false;

  ldflags = [ "-s" "-w" "-X github.com/superfly/flyctl/flyctl.Version=${version}" "-X github.com/superfly/flyctl/flyctl.Commit=${src.rev}" "-X github.com/superfly/flyctl/flyctl.BuildDate=1970-01-01T00:00:00+0000" "-X github.com/superfly/flyctl/flyctl.Environment=production" ];

  meta = with lib; {
    description = "Command line tools for fly.io services";
    homepage = "https://fly.io/";
    license = licenses.asl20;
    maintainers = with maintainers; [ aaronjanse ];
  };
}
