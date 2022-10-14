import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_chess_board/models/board_arrow.dart';
import 'package:simple_chess_board/simple_chess_board.dart';
import 'package:chess/chess.dart' as chess;

import '../components/simple_moves_history.dart';
import '../logic/utils.dart';

class GifEditionScreen extends StatefulWidget {
  const GifEditionScreen({super.key});

  @override
  State<GifEditionScreen> createState() => _GifEditionScreenState();
}

class _GifEditionScreenState extends State<GifEditionScreen> {
  bool _gameStart = true;
  final List<String> _movesSans = [];
  final chess.Chess _gameLogic = chess.Chess();
  BoardArrow? _lastMoveToHighlight;

  @override
  void initState() {
    final moveNumberCaption = "${_gameLogic.fen.split(' ')[5]}.";
    _movesSans.add(moveNumberCaption);
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
    //TODO implement promotion logic
    return Future.value(PieceType.queen);
  }

  void _onGenerateGif() {}

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.pages_gif_edition_title,
        ),
      ),
      body: Center(
        child: isPortrait
            ? PortraitContent(
                positionFen: _gameLogic.fen,
                movesSans: _movesSans,
                lastMoveToHighlight: _lastMoveToHighlight,
                onMove: _checkMove,
                onPromotion: _checkPromotion,
                onGenerateGif: _onGenerateGif,
              )
            : LandscapeContent(
                positionFen: _gameLogic.fen,
                movesSans: _movesSans,
                lastMoveToHighlight: _lastMoveToHighlight,
                onMove: _checkMove,
                onPromotion: _checkPromotion,
                onGenerateGif: _onGenerateGif,
              ),
      ),
    );
  }
}

class PortraitContent extends StatelessWidget {
  final String positionFen;
  final List<String> movesSans;
  final BoardArrow? lastMoveToHighlight;

  final void Function({required ShortMove move}) onMove;
  final Future<PieceType?> Function() onPromotion;
  final void Function() onGenerateGif;

  const PortraitContent({
    super.key,
    required this.positionFen,
    required this.movesSans,
    required this.lastMoveToHighlight,
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
      final fontSize = minSize * 0.05;
      final boardSize = minSize * 0.80;
      final gapSize = fontSize * 0.4;
      const buttonHeight = 30;
      final historyAvailableWidth = constraints.maxWidth;
      final historyAvailableHeight =
          constraints.maxHeight - boardSize - gapSize * 2 - buttonHeight;
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: boardSize,
            height: boardSize,
            child: SimpleChessBoard(
              whitePlayerType: PlayerType.human,
              blackPlayerType: PlayerType.human,
              fen: positionFen,
              onMove: onMove,
              onPromote: onPromotion,
              orientation: BoardColor.white,
              engineThinking: false,
              lastMoveToHighlight: lastMoveToHighlight,
              showCoordinatesZone: true,
            ),
          ),
          SizedBox(
            height: gapSize,
          ),
          SimpleMovesHistory(
            movesSans: movesSans,
            fontSize: fontSize,
            width: historyAvailableWidth,
            height: historyAvailableHeight,
          ),
          SizedBox(
            height: gapSize,
          ),
          ElevatedButton(
            onPressed: onGenerateGif,
            child: Text(
              AppLocalizations.of(context)!.pages_gif_edition_generate_button,
            ),
          ),
        ],
      );
    });
  }
}

class LandscapeContent extends StatelessWidget {
  final String positionFen;
  final List<String> movesSans;
  final BoardArrow? lastMoveToHighlight;

  final void Function({required ShortMove move}) onMove;
  final Future<PieceType?> Function() onPromotion;
  final void Function() onGenerateGif;

  const LandscapeContent({
    super.key,
    required this.positionFen,
    required this.movesSans,
    required this.lastMoveToHighlight,
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
      final fontSize = minSize * 0.05;
      final boardSize = minSize * 1.0;
      final gapSize = fontSize * 0.4;
      const buttonSize = 10;
      final historyAvailableWidth = constraints.maxWidth - gapSize - boardSize;
      final historyAvailableHeight =
          constraints.maxHeight - gapSize - buttonSize;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: boardSize,
            height: boardSize,
            child: SimpleChessBoard(
              whitePlayerType: PlayerType.human,
              blackPlayerType: PlayerType.human,
              fen: positionFen,
              onMove: onMove,
              onPromote: onPromotion,
              orientation: BoardColor.white,
              engineThinking: false,
              lastMoveToHighlight: lastMoveToHighlight,
              showCoordinatesZone: true,
            ),
          ),
          SizedBox(
            width: gapSize,
          ),
          Column(
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.8,
                child: SimpleMovesHistory(
                  width: historyAvailableWidth,
                  height: historyAvailableHeight,
                  movesSans: movesSans,
                  fontSize: fontSize,
                ),
              ),
              SizedBox(
                height: gapSize,
              ),
              ElevatedButton(
                onPressed: onGenerateGif,
                child: Text(
                  AppLocalizations.of(context)!
                      .pages_gif_edition_generate_button,
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
