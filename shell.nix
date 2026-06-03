{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = [
    pkgs.cmake-language-server
    pkgs.clang
    pkgs.clang-tools
    pkgs.cmake
    pkgs.gcc
    pkgs.sdl3
    pkgs.sdl3-image
    pkgs.sdl3-ttf
  ];
}
