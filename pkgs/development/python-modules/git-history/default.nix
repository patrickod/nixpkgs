{ lib, buildPythonPackage, fetchFromGitHub, click , git, sqlite-utils, GitPython, pytest
# Check Inputs
, pytestCheckHook, setuptools, pythonOlder }:

buildPythonPackage rec {
  pname = "git-history";
  version = "0.6.1";

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "simonw";
    repo = pname;
    rev = version;
    sha256 = "sha256-Gbf4NcFu23o2nuUkUqka1o61H2cU61k6sk6netibL+Y";
  };

  propagatedBuildInputs = [ click sqlite-utils git GitPython setuptools pytest ];

  pythonImportsCheck = [
    "git_history"
    "git_history.cli"
  ];

  meta = with lib; {
    description = "Tools for analyzing Git history using SQLite";
    homepage = "https://github.com/simonw/git-history";
    license = licenses.asl20;
    maintainers = with maintainers; [ patrickod ];
  };
}
