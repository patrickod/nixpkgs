{ lib
, fetchFromGitHub
, fetchpatch
, buildPythonPackage
, fetchFromGitHub
, python
, pythonOlder
, stdenv
}:

buildPythonPackage rec {
  pname = "websockets";
  version = "10.0";
  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "aaugustin";
    repo = pname;
    rev = version;
    sha256 = "sha256-F10C8ukjYfbn2X2PMzrdSDqvs51/A9lx8Y3kv8YJ8Cw=";
  };

  patches = [
    (fetchpatch {
      name = "CVE-2021-33880.patch";
      url = "https://github.com/aaugustin/websockets/commit/547a26b685d08cac0aa64e5e65f7867ac0ea9bc0.patch";
      excludes = [ "docs/changelog.rst" ];
      sha256 = "1wgsvza53ga8ldrylb3rqc17yxcrchwsihbq6i6ldpycq83q5akq";
    })
  ];

  disabled = pythonOlder "3.3";

  # Tests fail on Darwin with `OSError: AF_UNIX path too long`
  doCheck = !stdenv.isDarwin;

  # Disable all tests that need to terminate within a predetermined amount of
  # time. This is nondeterministic.
  patchPhase = ''
    sed -i 's/with self.assertCompletesWithin.*:/if True:/' \
      tests/legacy/test_protocol.py
  '';

  checkPhase = ''
    runHook preCheck
    ${python.interpreter} -m unittest discover
    runHook postCheck
  '';

  pythonImportsCheck = [ "websockets" ];

  meta = with lib; {
    description = "WebSocket implementation in Python";
    homepage = "https://websockets.readthedocs.io/";
    license = licenses.bsd3;
    maintainers = with maintainers; [ fab ];
  };
}
