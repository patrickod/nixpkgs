{ pkgs, stdenv, buildPythonPackage, fetchPypi, neotime, neobolt, pytz }:

buildPythonPackage rec {
  pname = "neo4j";
  version = "1.7.6";

  src = fetchPypi {
    inherit pname version;
    sha256 = "82169d548f984f745a519bc8a70cce05662fb7e10ed0179984ca2d45736bc01e";
  };

  propagatedBuildInputs = [
    neotime
    neobolt
    pytz
  ];

  meta = with stdenv.lib; {
    homepage = "https://github.com/neo4j/neo4j-python-driver";
    description = "Neo4j Bolt driver for Python";
    license = licenses.asl20;
    maintainers = with maintainers; [ patrickod ];
  };
}
