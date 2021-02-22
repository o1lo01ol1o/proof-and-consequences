let 
config = {
    allowBroken = true;
  };
in 
with import <nixpkgs> {inherit config;};
let
  sources = {
    agda-categories = pkgs.fetchFromGitHub {
        owner = "agda";
        repo = "agda-categories";
        rev = "2128fab9e8d341364cbf784bb17c547bf73891de"; # 1.3.1
        sha256 = "08mc20qaz9vp5rhi60rh8wvjkg5aby3bgwwdhfnxha1663qf1q24";
    };
    agda-stdlib = pkgs.fetchFromGitHub {
        owner = "agda";
        repo = "agda-stdlib";
        rev = "9f929b4fe28bb7ba74b6b95d01ed0958343f3451"; # 1.3
        sha256 = "18kl20z3bjfgx5m3nvrdj5776qmpi7jl2p12pqybsls2lf86m0d5";
    };
    plfa = pkgs.fetchFromGitHub {
        owner = "plfa";
        repo = "plfa.github.io";
        rev = "36ef980840517c39a7d63c94787d661e283ba180"; # master 6/25/20
        sha256 = "16h7izl6zdr6qch10qc694mrck1d4g6g5a7srsxxmsp2pb1r2983";
    };

    };
  pkgs = import (builtins.fetchTarball {
    url =
      "https://github.com/NixOS/nixpkgs/archive/58c19a2b0bbf75e68b1946460737c3f8a74b0f33.tar.gz";
    sha256 = "1lqfcx7mq453994lhjmk4yrszi49a2zf93xph6qclgd6idqydn59";
  }) { };

  # The standard library in nixpkgs does not come with a *.agda-lib file, so we
  # generate it here.
  standard-library-agda-lib = pkgs.writeText "standard-library.agda-lib" ''
    name: standard-library
    include: ${sources.agda-stdlib}/share/agda
  '';

  # Agda uses the AGDA_DIR environmental variable to determine where to load
  # default libraries from. This should have a few files in it, including the
  # "defaults" and "libraries" files generated below.
  #
  # More information (and possibilities!) are detailed here:
  # https://agda.readthedocs.io/en/v2.6.0.1/tools/package-system.html
  agdaDir = pkgs.stdenv.mkDerivation {
    name = "agdaDir";

    phases = [ "installPhase" ];

    # If you want to add more libraries simply list more in the $out/libraries
    # and $out/defaults folder.
    installPhase = ''
      mkdir $out
      echo "${standard-library-agda-lib}" >> $out/libraries
      echo "${sources.plfa + /plfa.agda-lib}" >> $out/libraries
      echo "standard-library" >> $out/defaults
      echo "plfa" >> $out/defaults
    '';
  };

in pkgs.mkShell {
  name = "agda-shell-with-stdlib";
  builtInputs = [ pkgs.haskellPackages.Agda pkgs.emacs ];

  # The build environment's $AGDA_DIR is set through this call.
  AGDA_DIR = agdaDir;
}