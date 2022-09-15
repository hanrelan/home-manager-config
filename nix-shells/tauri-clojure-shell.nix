{ pkgs ? import <nixpkgs> { } }:

with pkgs;
mkShell {

  buildInputs = [
    nodejs-16_x
    yarn
    libiconv
    rustc
    cargo
    jdk8
    darwin.apple_sdk.frameworks.Security
    darwin.apple_sdk.frameworks.AppKit
    darwin.apple_sdk.frameworks.WebKit

  ];
  shellHook = ''
    unset LD
    unset LD_DYLD_PATH
    export CC=/usr/bin/cc
    export LD=/usr/bin/ld
  '';
}
