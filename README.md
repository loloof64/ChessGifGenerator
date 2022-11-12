# Chess animated gif creator

Create an animated GIF from your chess game.

* You can enter the moves manually, or use the main line of a game from PGN file
* You can choose the overall time of the images in the animation file
* You can choose the size in pixels of the image
* You can choose to remove last move arrows and coordinates around the board

## Credits

* Font freeSerif was downloaded from [Fonts2U](https://fr.fonts2u.com/download/free-serif.police).

* Adapted PGN PEG rules at https://github.com/mliebelt/pgn-parser/blob/master/src/pgn-rules.pegjs from project [pgn-parser](https://github.com/mliebelt/pgn-parser/blob/master/src/pgn-rules.pegjs), which is release under Apache License 2.0 (even if some elements - specially special kind of comments - have been removed).

Download some images from [Lucide](https://lucide.dev) :
- first_item : downloaded at https://lucide.dev/icon/chevron-first
- last_item : downloaded at https://lucide.dev/icon/chevron-last
- previous_item : downloaded at https://lucide.dev/icon/chevron-left
- next_item : downloaded at https://lucide.dev/icon/chevron-right

* Icon file has been downloaded from [Freepik](https://www.freepik.com) : https://www.freepik.com/free-vector/chess-game-isometric-concept_6883519.htm.

## Developers

### Generating translations files

`flutter gen-l10n`

### Building AppImage for Linux

1. Setup Docker (docker-ce-cli is free) on your Linux Host
2. Go into the root of the project from your terminal
3. Build the base image : `docker build -t flutter_linux_build .`
4. Build the AppImage inside a container: `docker run -ti --mount type=bind,source=$(pwd),target=/home/developer/project flutter_linux_build bash`
5. Inside the container, run `cd project`
6. Go on with the following command `flutter clean`
7. Now `flutter build linux`
8. Run `appimage-builder --recipe AppImageBuilder.yml`

Your AppImage should have been generated in the root of the project, so you can close the running Docker container (run `exit`).

### Zipping necessary files for Windows

1. Build application in release mode.
2. Copy the the content of the folder build\windows\runner\Release (all the dll and the data folder) in an empty  folder of your choice (we'll be zipping it later)
3. Copy the following dll, from the folder C:\Windows\System32, into the previous folder
    * msvcp140.dll
    * vcruntime140.dll
    * vcruntime140_1.dll
4. You can the zip the folder and distribute.
