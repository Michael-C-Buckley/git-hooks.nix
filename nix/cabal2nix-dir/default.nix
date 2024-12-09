{ writeScriptBin, cabal2nix }:

writeScriptBin "cabal2nix-dir" ''#!/usr/bin/env bash
  projectdir="$(pwd)"
  outputFileName=""
  cabalFiles=()

  for arg in "$@"; do
    if [[ "$arg" == --outputFileName=* ]]; then
      outputFileName="''${arg#--outputFileName=}"
    else
      cabalFiles+=("$arg")
    fi
  done

  for cabalFile in "''${cabalFiles[@]}"; do
    echo "$cabalFile"
    dir="$(dirname $cabalFile)"
    cd "$projectdir/$dir"
    ${cabal2nix}/bin/cabal2nix --no-hpack . > "$outputFileName"
  done
''
