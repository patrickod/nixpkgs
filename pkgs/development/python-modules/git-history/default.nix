{ lib, buildPythonPackage, fetchFromGitHub, click , git, sqlite-utils, GitPython, pytest
# Check Inputs
, pytestCheckHook, setuptools, pythonOlder }:

buildPythonPackage rec {
  pname = "git-history";
  version = "0.7a0";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "simonw";
    repo = pname;
    rev = version;
    sha256 = "sha256-6v5y2vguQKoDp02XjJI5gB6qLTmf5wkhnhKsW+8lQ/w=";
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
