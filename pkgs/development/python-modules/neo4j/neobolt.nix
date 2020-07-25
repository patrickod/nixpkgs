{ stdenv, buildPythonPackage, fetchPypi}:

buildPythonPackage rec {
  pname = "neobolt";
  version = "1.7.17";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1d0d5efce7221fc4f0ffc4a315bc5272708be5aa2aef5434269e800372d8db89";
  };

  meta = with stdenv.lib; {
    homepage = "https://github.com/neo4j-drivers/neobolt";
    description = "Neo4j Bolt driver for Python";
    license = licenses.asl20;
    maintainers = with maintainers; [ patrickod ];
  };
}
