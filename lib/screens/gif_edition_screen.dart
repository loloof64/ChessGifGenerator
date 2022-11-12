import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_chess_board/models/board_arrow.dart';
import 'package:simple_chess_board/simple_chess_board.dart';
import 'package:chess_vectors_flutter/chess_vectors_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:chess/chess.dart' as chess;
import 'package:image/image.dart' as image_lib;
import 'package:path/path.dart' as p;

import '../components/simple_moves_history.dart';
import '../logic/utils.dart';

class GifEditionScreen extends StatefulWidget {
  final dynamic game;
  const GifEditionScreen({
    super.key,
    this.game,
  });

  @override
  State<GifEditionScreen> createState() => _GifEditionScreenState();
}

class _GifEditionScreenState extends State<GifEditionScreen> {
  bool _gameStart = true;
  final List<String> _movesSans = [];
  chess.Chess _gameLogic = chess.Chess();
  BoardArrow? _lastMoveToHighlight;
  PlayerType _whitePlayerType = PlayerType.human;
  PlayerType _blackPlayerType = PlayerType.human;
  ScreenshotController screenshotController = ScreenshotController();
  bool _isBusyGeneratingGif = false;
  bool _includeArrows = true;
  bool _includeCoordinates = true;
  double _framerateMs = 1000;
  int _targetSizePx = 300;
  final TextEditingController _sizeTextController = TextEditingController();
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  void initState() {
    _sizeTextController.text = _targetSizePx.toString();
    if (widget.game != null) {
      var gameData = widget.game['moves']['pgn'];
      var moveIndex = 0;
      for (var node in gameData) {
        if (moveIndex % 2 == 0) {
          _movesSans.add('${(moveIndex / 2 + 1).round()}.');
        }
        final currentData = node['halfMove'];
        final currentSan = currentData['notation'];
        _gameLogic.move(currentSan);
        _movesSans.add(currentSan);
        final lastMove = _gameLogic.history.last;
        _lastMoveToHighlight = BoardArrow(
          from: lastMove.move.fromAlgebraic,
          to: lastMove.move.toAlgebraic,
          color: Colors.blueAccent,
        );
        moveIndex++;
      }
    } else {
      const moveNumberCaption = "1.";
      _movesSans.add(moveNumberCaption);
    }
    super.initState();
  }

  void _checkMove({required ShortMove move}) {
    final moveHasBeenMade = _gameLogic.move({
      'from': move.from,
      'to': move.to,
      'promotion': move.promotion.map((t) => t.name).toNullable(),
    });
    if (moveHasBeenMade) {
      final whiteMove = _gameLogic.turn == chess.Color.WHITE;
      final lastPlayedMove = _gameLogic.history.last.move;

      /*
      We need to know if it was white move before the move which
      we want to add history node(s).
      */
      if (!whiteMove && !_gameStart) {
        final moveNumberCaption = "${_gameLogic.fen.split(' ')[5]}.";
        setState(() {
          _movesSans.add(moveNumberCaption);
        });
      }

      // In order to get move SAN, it must not be done on board yet !
      // So we rollback the move, then we'll make it happen again.
      _gameLogic.undo_move();
      final san = _gameLogic.move_to_san(lastPlayedMove);
      _gameLogic.make_move(lastPlayedMove);

      final fan = san.toFan(whiteMove: !whiteMove);

      setState(() {
        _movesSans.add(fan);
        _lastMoveToHighlight = BoardArrow(
          from: move.from,
          to: move.to,
          color: Colors.blueAccent,
        );
        _gameStart = false;
      });
    }
  }

  Future<PieceType?> _checkPromotion() {
    final whiteTurn = _gameLogic.fen.split(' ')[1] == 'w';
    const piecesSize = 60.0;
    return showDialog<PieceType>(
        context: context,
        builder: (ctx2) {
          return AlertDialog(
            alignment: Alignment.center,
            content: FittedBox(
                child: Row(
              children: [
                InkWell(
                  child: whiteTurn
                      ? WhiteQueen(
                          size: piecesSize,
                        )
                      : BlackQueen(
                          size: piecesSize,
                        ),
                  onTap: () {
                    Navigator.of(context).pop(PieceType.queen);
                  },
                ),
                InkWell(
                  child: whiteTurn
                      ? WhiteRook(
                          size: piecesSize,
                        )
                      : BlackRook(
                          size: piecesSize,
                        ),
                  onTap: () {
                    Navigator.of(context).pop(PieceType.rook);
                  },
                ),
                InkWell(
                  child: whiteTurn
                      ? WhiteBishop(
                          size: piecesSize,
                        )
                      : BlackBishop(
                          size: piecesSize,
                        ),
                  onTap: () {
                    Navigator.of(context).pop(PieceType.bishop);
                  },
                ),
                InkWell(
                  child: whiteTurn
                      ? WhiteKnight(
                          size: piecesSize,
                        )
                      : BlackKnight(
                          size: piecesSize,
                        ),
                  onTap: () {
                    Navigator.of(context).pop(PieceType.knight);
                  },
                ),
              ],
            )),
          );
        });
  }

  void _onGenerateGif() async {
    final movesSans = _gameLogic.getHistory();
    const baseFilename = 'screenshot';
    setState(() {
      _isBusyGeneratingGif = true;
      _gameLogic = chess.Chess();
      _lastMoveToHighlight = null;
      _whitePlayerType = PlayerType.computer;
      _blackPlayerType = PlayerType.computer;
    });
    Directory tempDir = await getTemporaryDirectory();
    Directory screenshotsDir =
        Directory('${tempDir.path}${Platform.pathSeparator}chess_screenshots');
    await screenshotsDir.create();

    Future.delayed(const Duration(milliseconds: 100), () {
      _takeGameStepScreenshot(
        stepIndex: -1,
        tempStorageDirPath: screenshotsDir.path,
        baseFilename: baseFilename,
        movesSans: movesSans,
      );
    });
  }

  void _takeGameStepScreenshot({
    required int stepIndex,
    required String tempStorageDirPath,
    required String baseFilename,
    required List<dynamic> movesSans,
  }) async {
    if (stepIndex >= movesSans.length) {
      await compute(_mergeScreenshotsIntoGif, {
        'gameStepsCount': movesSans.length,
        'tempStorageDirPath': tempStorageDirPath,
        'baseFilename': baseFilename,
        'imageDurationMs': _framerateMs,
      });
      setState(() {
        _isBusyGeneratingGif = false;
      });

      if (!mounted) return;
      final result = await FilePicker.platform.saveFile(
          dialogTitle:
              AppLocalizations.of(context)!.pages_gif_edition_select_save_file);
      if (result != null) {
        final targetFilePath = result;
        final originalFile = File(
            '$tempStorageDirPath${Platform.pathSeparator}$baseFilename.gif');
        await originalFile.copy(targetFilePath);
      }

      final tempDirectory = File(tempStorageDirPath);
      tempDirectory.delete(recursive: true);

      if (!mounted) return;
      final doneSnackbar = SnackBar(
        content: Text(AppLocalizations.of(context)!
            .pages_gif_edition_success_generating_gif),
      );
      ScaffoldMessenger.of(context).showSnackBar(doneSnackbar);

      setState(() {
        _whitePlayerType = PlayerType.human;
        _blackPlayerType = PlayerType.human;
      });

      return;
    }

    final fileName = '${baseFilename}_${stepIndex + 1}.png';
    if (stepIndex > -1) {
      final currentMoveSan = movesSans[stepIndex];
      setState(() {
        _gameLogic.move(currentMoveSan);
      });
      final lastMove = _gameLogic.getHistory({'verbose': true}).last;
      setState(() {
        _lastMoveToHighlight = BoardArrow(
            from: lastMove['from'],
            to: lastMove['to'],
            color: Colors.blueAccent);
      });
    }
    Future.delayed(const Duration(milliseconds: 100), () async {
      var imageData = await screenshotController.capture(
          delay: const Duration(milliseconds: 100));
      if (imageData == null) {
        if (!mounted) return;
        final snackBar = SnackBar(
          content: Text(AppLocalizations.of(context)!
              .pages_gif_edition_error_taking_screenshot),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }

      var image = image_lib.decodeImage(imageData);
      if (image == null) {
        if (!mounted) return;
        final snackBar = SnackBar(
          content: Text(AppLocalizations.of(context)!
              .pages_gif_edition_error_taking_screenshot),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }

      var resizedImage = image_lib.copyResize(image,
          width: _targetSizePx, height: _targetSizePx);
      var resizedImageBytes = image_lib.encodePng(resizedImage);

      File(p.join(tempStorageDirPath, fileName))
          .writeAsBytes(resizedImageBytes);

      _takeGameStepScreenshot(
        stepIndex: stepIndex + 1,
        tempStorageDirPath: tempStorageDirPath,
        baseFilename: baseFilename,
        movesSans: movesSans,
      );
    });
  }

  void _onIncludeArrowsChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _includeArrows = newValue;
    });
  }

  void _onIncludeCoordinatesChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _includeCoordinates = newValue;
    });
  }

  void _onFramerateChanged(double newValue) {
    setState(() {
      _framerateMs = newValue;
    });
  }

  void _onSizeUpdated(int newValue) {
    setState(() {
      _targetSizePx = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.pages_gif_edition_title,
        ),
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Builder(
                builder: ((context) => InkWell(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                    )),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_sharp,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
      drawer: Container(
        key: _drawerKey,
        color: Colors.white,
        child: Center(
          child: _isBusyGeneratingGif
              ? Text(AppLocalizations.of(context)!
                  .pages_gif_edition_no_option_while_generating)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        AppLocalizations.of(context)!.buttons_go_back,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Checkbox(
                            value: _includeCoordinates,
                            onChanged: _onIncludeCoordinatesChanged,
                          ),
                          Text(
                            AppLocalizations.of(context)!
                                .pages_gif_edition_include_coordinates,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Checkbox(
                            value: _includeArrows,
                            onChanged: _onIncludeArrowsChanged,
                          ),
                          Text(
                            AppLocalizations.of(context)!
                                .pages_gif_edition_include_arrows,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        AppLocalizations.of(context)!
                            .pages_gif_edition_framerate,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Slider(
                        value: _framerateMs,
                        onChanged: _onFramerateChanged,
                        min: 500,
                        max: 1500,
                      ),
                    ),
                    Text(_framerateMs.toStringAsFixed(0)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        AppLocalizations.of(context)!
                            .pages_gif_edition_target_size,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextField(
                        keyboardType: const TextInputType.numberWithOptions(),
                        controller: _sizeTextController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                        onPressed: () =>
                            _onSizeUpdated(int.parse(_sizeTextController.text)),
                        child:
                            Text(AppLocalizations.of(context)!.buttons_update),
                      ),
                    ),
                  ],
                ),
        ),
      ),
      body: Stack(
        children: [
          isPortrait
              ? PortraitContent(
                  busyGeneratingGif: _isBusyGeneratingGif,
                  positionFen: _gameLogic.fen,
                  movesSans: _movesSans,
                  targetSizePx: _targetSizePx,
                  lastMoveToHighlight: _lastMoveToHighlight,
                  screenshotController: screenshotController,
                  whitePlayerType: _whitePlayerType,
                  blackPlayerType: _blackPlayerType,
                  includeArrows: _includeArrows,
                  includeCoordinates: _includeCoordinates,
                  sizePx: _targetSizePx,
                  onMove: _checkMove,
                  onPromotion: _checkPromotion,
                  onGenerateGif: _onGenerateGif,
                )
              : LandscapeContent(
                  busyGeneratingGif: _isBusyGeneratingGif,
                  positionFen: _gameLogic.fen,
                  movesSans: _movesSans,
                  targetSizePx: _targetSizePx,
                  lastMoveToHighlight: _lastMoveToHighlight,
                  screenshotController: screenshotController,
                  whitePlayerType: _whitePlayerType,
                  blackPlayerType: _blackPlayerType,
                  includeArrows: _includeArrows,
                  includeCoordinates: _includeCoordinates,
                  onMove: _checkMove,
                  onPromotion: _checkPromotion,
                  onGenerateGif: _onGenerateGif,
                ),
          if (_isBusyGeneratingGif)
            Center(
              child: LayoutBuilder(builder: (ctx2, constraints2) {
                final minSize = constraints2.maxWidth < constraints2.maxHeight
                    ? constraints2.maxWidth
                    : constraints2.maxHeight;
                return SizedBox(
                  width: minSize * 0.6,
                  height: minSize * 0.6,
                  child: const CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
              }),
            ),
        ],
      ),
    );
  }
}

class PortraitContent extends StatelessWidget {
  final bool busyGeneratingGif;
  final bool includeCoordinates;
  final bool includeArrows;
  final int targetSizePx;
  final String positionFen;
  final List<String> movesSans;
  final BoardArrow? lastMoveToHighlight;
  final ScreenshotController screenshotController;
  final PlayerType whitePlayerType;
  final PlayerType blackPlayerType;

  final void Function({required ShortMove move}) onMove;
  final Future<PieceType?> Function() onPromotion;
  final void Function() onGenerateGif;

  final TextEditingController _sizeTextController = TextEditingController();

  PortraitContent({
    super.key,
    required this.busyGeneratingGif,
    required this.includeArrows,
    required this.includeCoordinates,
    required this.targetSizePx,
    required this.positionFen,
    required this.movesSans,
    required this.lastMoveToHighlight,
    required this.screenshotController,
    required this.whitePlayerType,
    required this.blackPlayerType,
    required this.onMove,
    required this.onPromotion,
    required this.onGenerateGif,
    required int sizePx,
  }) {
    _sizeTextController.text = sizePx.toString();
  }

  @override
  Widget build(BuildContext context) {
    const gapSize = 10.0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 10,
          child: Screenshot(
            controller: screenshotController,
            child: SimpleChessBoard(
              whitePlayerType: whitePlayerType,
              blackPlayerType: blackPlayerType,
              fen: positionFen,
              onMove: onMove,
              onPromote: onPromotion,
              orientation: BoardColor.white,
              engineThinking: false,
              lastMoveToHighlight: includeArrows ? lastMoveToHighlight : null,
              showCoordinatesZone: includeCoordinates,
            ),
          ),
        ),
        const SizedBox(
          height: gapSize,
        ),
        Expanded(
          flex: 6,
          child: LayoutBuilder(builder: (ctx2, constraints2) {
            return SingleChildScrollView(
              child: SimpleMovesHistory(
                movesSans: movesSans,
                fontSize: constraints2.biggest.width * 0.1,
                width: constraints2.biggest.width,
                height: constraints2.biggest.height,
              ),
            );
          }),
        ),
        if (!busyGeneratingGif)
          Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: onGenerateGif,
              child: Text(
                AppLocalizations.of(context)!.pages_gif_edition_generate_button,
              ),
            ),
          ),
      ],
    );
  }
}

class LandscapeContent extends StatelessWidget {
  final bool busyGeneratingGif;
  final bool includeCoordinates;
  final bool includeArrows;
  final int targetSizePx;
  final String positionFen;
  final List<String> movesSans;
  final BoardArrow? lastMoveToHighlight;
  final ScreenshotController screenshotController;
  final PlayerType whitePlayerType;
  final PlayerType blackPlayerType;

  final void Function({required ShortMove move}) onMove;
  final Future<PieceType?> Function() onPromotion;
  final void Function() onGenerateGif;

  const LandscapeContent({
    super.key,
    required this.busyGeneratingGif,
    required this.includeArrows,
    required this.includeCoordinates,
    required this.targetSizePx,
    required this.positionFen,
    required this.movesSans,
    required this.lastMoveToHighlight,
    required this.screenshotController,
    required this.whitePlayerType,
    required this.blackPlayerType,
    required this.onMove,
    required this.onPromotion,
    required this.onGenerateGif,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx2, constraints) {
      final minSize = constraints.maxWidth < constraints.maxHeight
          ? constraints.maxWidth
          : constraints.maxHeight;
      final maxSize = constraints.maxWidth > constraints.maxHeight
          ? constraints.maxWidth
          : constraints.maxHeight;
      final fontSize = minSize * 0.05;
      final boardSize = maxSize * 0.50;
      final gapSize = fontSize * 0.1;
      final controlsZone = busyGeneratingGif ? 0 : 100 + 6 * gapSize;
      final historyAvailableWidth = constraints.maxWidth - gapSize - boardSize;
      final historyAvailableHeight = constraints.maxHeight - controlsZone;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: boardSize,
            height: boardSize,
            child: Screenshot(
              controller: screenshotController,
              child: SimpleChessBoard(
                whitePlayerType: whitePlayerType,
                blackPlayerType: blackPlayerType,
                fen: positionFen,
                onMove: onMove,
                onPromote: onPromotion,
                orientation: BoardColor.white,
                engineThinking: false,
                lastMoveToHighlight: includeArrows ? lastMoveToHighlight : null,
                showCoordinatesZone: includeCoordinates,
              ),
            ),
          ),
          SizedBox(
            width: gapSize,
          ),
          Column(
            children: [
              Expanded(
                flex: 8,
                child: SimpleMovesHistory(
                  width: historyAvailableWidth,
                  height: historyAvailableHeight,
                  movesSans: movesSans,
                  fontSize: fontSize,
                ),
              ),
              if (!busyGeneratingGif)
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: onGenerateGif,
                    child: Text(
                      AppLocalizations.of(context)!
                          .pages_gif_edition_generate_button,
                    ),
                  ),
                ),
            ],
          ),
        ],
      );
    });
  }
}

void _mergeScreenshotsIntoGif(Map<String, dynamic> parameters) async {
  final animation = image_lib.Animation();
  final outputGif = image_lib.GifEncoder();
  final imageDecoder = image_lib.PngDecoder();
  for (var stepIndex = 0;
      stepIndex <= parameters['gameStepsCount'];
      stepIndex++) {
    final currentFile = File(
        '${parameters['tempStorageDirPath']}${Platform.pathSeparator}${parameters['baseFilename']}_$stepIndex.png');
    final currentImageBytes = await currentFile.readAsBytes();
    final currentImage = imageDecoder.decodeImage(currentImageBytes)!;
    outputGif.addFrame(currentImage,
        duration: parameters['imageDurationMs'] ~/ 10);
  }
  final gifData = outputGif.encodeAnimation(animation);
  final destinationFile = File(
      '${parameters['tempStorageDirPath']}${Platform.pathSeparator}${parameters['baseFilename']}.gif');
  await destinationFile.writeAsBytes(gifData!);
}
