{ pkgs, stdenv, buildPythonPackage, fetchPypi,
  python-dateutil, requests }:

buildPythonPackage rec {
  pname = "okta";
  version = "0.0.4";

  src = fetchPypi {
    inherit pname version;
    sha256 = "53e792c68d3684ff4140b4cb1c02af3821090368f8110fde54c0bdb638449332";
  };

  preBuild = "sed 's/>=[0-9.]*//g' -i setup.py";

  doCheck = false;

  propagatedBuildInputs = [
    python-dateutil
    requests
  ];

  meta = with stdenv.lib; {
    homepage = "https://github.com/okta/okta-sdk-python";
    description = "Okta Python SDK";
    license = licenses.asl20;
    maintainers = with maintainers; [ patrickod ];
  };
}
