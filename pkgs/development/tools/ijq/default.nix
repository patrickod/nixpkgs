{ buildGoModule, fetchFromSourcehut, lib, jq, installShellFiles, makeWrapper, scdoc }:

buildGoModule rec {
  pname = "ijq";
  version = "0.3.4";

  src = fetchFromSourcehut {
    owner = "~gpanders";
    repo = pname;
    rev = "v${version}";
    sha256 = "ZKxEK6SPxEC0S5yXSzITPn0HhpJa4Bcf9X8/N+ZZAeA=";
  };

  vendorSha256 = "04KlXE2I8ZVDbyo9tBnFskLB6fo5W5/lPzSpo8KGqUU=";

  nativeBuildInputs = [ installShellFiles makeWrapper scdoc ];

  ldflags = [ "-s" "-w" "-X main.Version=${version}" ];

  postBuild = ''
    scdoc < ijq.1.scd > ijq.1
    installManPage ijq.1
  '';

  postInstall = ''
    wrapProgram "$out/bin/ijq" \
      --prefix PATH : "${lib.makeBinPath [ jq ]}"
  '';

  meta = with lib; {
    description = "Interactive wrapper for jq";
    homepage = "https://git.sr.ht/~gpanders/ijq";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ justinas SuperSandro2000 ];
  };
}
