{ lib
, buildPythonPackage
, fetchFromGitHub
, fetchpatch
, aniso8601
, jsonschema
, flask
, werkzeug
, pytz
, faker
, six
, mock
, blinker
, pytest-flask
, pytest-mock
, pytest-benchmark
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "flask-restx";
  version = "0.5.1";

  # Tests not included in PyPI tarball
  src = fetchFromGitHub {
    owner = "python-restx";
    repo = pname;
    rev = version;
    sha256 = "18vrmknyxw6adn62pz3kr9kvazfgjgl4pgimdf8527fyyiwcqy15";
  };

  patches = [
    (fetchpatch {
      name = "CVE-2021-32838.patch";
      url = "https://github.com/python-restx/flask-restx/commit/bab31e085f355dd73858fd3715f7ed71849656da.patch";
      sha256 = "1n786f0zq3gyrp9s28qw3j8bkqhys38vbaafaizplaf4f76bh7m8";
    })
  ];

  propagatedBuildInputs = [ aniso8601 jsonschema flask werkzeug pytz six ]
    ++ lib.optionals isPy27 [ enum34 ];

  checkInputs = [
    blinker
    faker
    mock
    pytest-benchmark
    pytest-flask
    pytest-mock
    pytestCheckHook
  ];

  pytestFlagsArray = [
    "--benchmark-disable"
    "--deselect=tests/test_inputs.py::URLTest::test_check"
    "--deselect=tests/test_inputs.py::EmailTest::test_valid_value_check"
    "--deselect=tests/test_logging.py::LoggingTest::test_override_app_level"
  ];

  pythonImportsCheck = [ "flask_restx" ];

  meta = with lib; {
    homepage = "https://flask-restx.readthedocs.io/en/${version}/";
    description = "Fully featured framework for fast, easy and documented API development with Flask";
    changelog = "https://github.com/python-restx/flask-restx/raw/${version}/CHANGELOG.rst";
    license = licenses.bsd3;
    maintainers = [ maintainers.marsam ];
  };
}
