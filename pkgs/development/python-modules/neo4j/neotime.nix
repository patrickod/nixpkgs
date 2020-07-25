{ stdenv, buildPythonPackage, fetchPypi, pytz, six }:

buildPythonPackage rec {
  pname = "neotime";
  version = "1.7.4";

  src = fetchPypi {
    inherit pname version;
    sha256 = "4e0477ba0f24e004de2fa79a3236de2bd941f20de0b5db8d976c52a86d7363eb";
  };

  propagatedBuildInputs = [
    pytz
    six
  ];

  meta = with stdenv.lib; {
    homepage = "https://github.com/neo4j/neo4j-python-driver";
    description = "Nanosecond resolution temporal types";
    license = licenses.asl20;
    maintainers = with maintainers; [ patrickod ];
  };
}
