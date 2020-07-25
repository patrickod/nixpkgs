{ fetchFromGitHub, python38Packages, stdenv }:

python38Packages.buildPythonApplication rec {
  pname = "cartography";
  version = "0.24.0";

  src = fetchFromGitHub {
    owner = "lyft";
    repo = "${pname}";
    rev = "${version}";
    sha256 = "02qqd6v73wbwihpw2z3ydxf0rywzic5zzw3ah3jknfbfk2zb30x8";
  };

  checkInputs = with python38Packages; [
    pytest
  ];

  propagatedBuildInputs = with python38Packages; [
    boto3
    botocore
    dnspython
    neo4j
    neobolt
    policyuniverse
    google_api_python_client
    oauth2client
    marshmallow
    okta
    pyyaml
    requests
    statsd
  ];

  meta = with stdenv.lib; {
    homepage = "https://github.com/lyft/cartography";
    description = "Cartography is a Python tool that consolidates infrastructure assets and the relationships between them in an intuitive graph view powered by a Neo4j database.";
    license = licenses.asl20;
    maintainers = [ maintainers.patrickod ];
  };
}
