{ lib
, buildPythonPackage
, fetchFromGitHub
, pydantic
, starlette
, pytestCheckHook
, pytest-asyncio
, aiosqlite
, databases
, flask
, httpx
, passlib
, peewee
, python-jose
, sqlalchemy
, trio
}:

buildPythonPackage rec {
  pname = "fastapi";
  version = "0.65.2";
  format = "flit";

  src = fetchFromGitHub {
    owner = "tiangolo";
    repo = "fastapi";
    rev = version;
    sha256 = "032srvbfdy02m1b664x67lkdcx6b2bd4c9a9cb176lscjk213240";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace "starlette ==" "starlette >="
  '';

  propagatedBuildInputs = [
    starlette
    pydantic
  ];

  checkInputs = [
    aiosqlite
    databases
    flask
    httpx
    passlib
    peewee
    python-jose
    pytestCheckHook
    pytest-asyncio
    sqlalchemy
    trio
  ];

  # disabled tests require orjson which requires rust nightly

  # ignoring deprecation warnings to avoid test failure from
  # tests/test_tutorial/test_testing/test_tutorial001.py

  pytestFlagsArray = [
    "--ignore=tests/test_default_response_class.py"
    "-W ignore::DeprecationWarning"
  ];

  disabledTests = [
    "test_get_custom_response"

    # Failed: DID NOT RAISE <class 'starlette.websockets.WebSocketDisconnect'>
    "test_websocket_invalid_data"
    "test_websocket_no_credentials"
  ];

  meta = with lib; {
    homepage = "https://github.com/tiangolo/fastapi";
    description = "FastAPI framework, high performance, easy to learn, fast to code, ready for production";
    license = licenses.mit;
    maintainers = with maintainers; [ wd15 ];
  };
}
