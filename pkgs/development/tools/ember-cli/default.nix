{ mkYarnPackage, fetchFromGitHub, lib }:

mkYarnPackage rec {
  pname = "ember-cli";
  version = "3.25.0";

  src = fetchFromGitHub {
    owner = "ember-cli";
    repo = "ember-cli";
    rev = "v${version}";
    sha256 = "0zl3bpc1qfvxcrr54dhpkynjjrgfg9cmsh27a5frg6kacl0vpc9k";
  };

  meta = with lib; {
    homepage = "https://github.com/ember-cli/ember-cli";
    description = "The Ember.js command line utility";
    maintainers = with maintainers; [ patrickod ];
    platforms = platforms.all;
    gelicense = licenses.mit;
  };
}
