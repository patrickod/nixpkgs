{ lib, buildPythonPackage, fetchFromGitHub
, requests }:

buildPythonPackage rec {
  pname = "python-pushover";
  version = "1.2";

  src = fetchFromGitHub {
    owner = "almir1904";
    repo = "python-pushover";
    rev = "master";
    sha256 = "sha256-RRc8ld0pq2mf6gzHq0PhZEQ2cshyt1SQiGT3P21JGNk";
  };

  propagatedBuildInputs = [ requests ];

  # tests require network
  doCheck = false;

  meta = with lib; {
    description = "Bindings and command line utility for the Pushover notification service";
    homepage = "https://github.com/Thibauth/python-pushover";
    license = licenses.gpl3;
    maintainers = with maintainers; [ peterhoeg ];
  };
}
