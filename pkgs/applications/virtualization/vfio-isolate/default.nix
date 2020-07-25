{ stdenv, fetchFromGitHub, python38Packages }:

python38Packages.buildPythonApplication rec {
  pname = "vfio-isolate";
  version = "0.3.1";

  src = fetchFromGitHub {
    owner = "spheenik";
    repo = "${pname}";
    rev = "74efc1ec4902866b72dd8068b505cb0900b9dd85";
    sha256 = "0ca50yvj3fcxj41bz3ajqmj8vhcmqy6akf6pn4vhmzkgvd4a2g2x";
  };

  propagatedBuildInputs = with python38Packages; [ click psutil parsimonious ];
  doCheck = false;

  meta = with stdenv.lib; {
    homepage = "https://github.com/spheenik/vfio-isolate";
    description = "CLI utility for facilitating memory and CPU isolation for VMs";
    license = licenses.mit;
    maintainers = [ maintainers.patrickod ];
    platforms = platforms.linux;
  };
}
