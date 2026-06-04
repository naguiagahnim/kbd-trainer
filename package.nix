{
  lib,
  stdenv,
  cmake,
  sdl3,
  sdl3-image,
  sdl3-ttf,
  makeDesktopItem,
}:
stdenv.mkDerivation {
  pname = "kbd-trainer";
  version = "1.0";

  src = ./.;

  nativeBuildInputs = [cmake];
  buildInputs = [
    sdl3
    sdl3-image
    sdl3-ttf
  ];

  desktopItems = [
    (
      makeDesktopItem {
        name = "kbdtrainer";
        exec = "KBDTrainer";
        desktopName = "KBD-Trainer";
      }
    )
  ];

  meta = {
    description = "A simple mini game for correct korean backdash inputs for Tekken";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
}
