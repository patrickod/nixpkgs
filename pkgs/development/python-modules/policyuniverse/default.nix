{ stdenv, buildPythonPackage, fetchPypi}:

buildPythonPackage rec {
  pname = "policyuniverse";
  version = "1.3.2.3";

  src = fetchPypi {
    inherit pname version;
    sha256 = "f4ef0576f1d0a448464a9f86a9cc9e00b3c5bc32c2a4a1b89dfb3d9b6324ac25";
  };

  meta = with stdenv.lib; {
    homepage = "https://github.com/Netflix-Skunkworks/policyuniverse";
    description = "Parse and Process AWS IAM Policies, Statements, ARNs, and wildcards";
    license = licenses.asl20;
    maintainers = with maintainers; [ patrickod ];
  };
}
