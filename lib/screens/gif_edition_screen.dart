import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_chess_board/simple_chess_board.dart';
import 'package:chess/chess.dart' as chess;

import '../components/simple_moves_history.dart';

class GifEditionScreen extends StatefulWidget {
  const GifEditionScreen({super.key});

  @override
  State<GifEditionScreen> createState() => _GifEditionScreenState();
}

class _GifEditionScreenState extends State<GifEditionScreen> {
  chess.Chess _gameLogic = chess.Chess();
  List<String> _movesSans = [
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
    'e4',
    'e5',
    'Cf3',
    'Cc6',
    'd4',
    'd5',
  ];

  void _checkMove({required ShortMove move}) {}

  Future<PieceType?> _checkPromotion() {
    return Future.value(PieceType.queen);
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
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
                onMove: _checkMove,
                onPromotion: _checkPromotion,
              )
            : LandscapeContent(
                positionFen: _gameLogic.fen,
                movesSans: _movesSans,
                onMove: _checkMove,
                onPromotion: _checkPromotion,
              ),
      ),
    );
  }
}

class PortraitContent extends StatelessWidget {
  final String positionFen;
  final List<String> movesSans;

  final void Function({required ShortMove move}) onMove;
  final Future<PieceType?> Function() onPromotion;

  const PortraitContent({
    super.key,
    required this.positionFen,
    required this.movesSans,
    required this.onMove,
    required this.onPromotion,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx2, constraints) {
      final minSize = constraints.maxWidth < constraints.maxHeight
          ? constraints.maxWidth
          : constraints.maxHeight;
      final fontSize = minSize * 0.05;
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SimpleChessBoard(
            whitePlayerType: PlayerType.human,
            blackPlayerType: PlayerType.human,
            fen: positionFen,
            onMove: onMove,
            onPromote: onPromotion,
            orientation: BoardColor.white,
            engineThinking: false,
            lastMoveToHighlight: null,
            showCoordinatesZone: true,
          ),
          SizedBox(
            height: fontSize * 0.4,
          ),
          SimpleMovesHistory(
            movesSans: movesSans,
            fontSize: fontSize,
          ),
        ],
      );
    });
  }
}

class LandscapeContent extends StatelessWidget {
  final String positionFen;
  final List<String> movesSans;

  final void Function({required ShortMove move}) onMove;
  final Future<PieceType?> Function() onPromotion;

  const LandscapeContent({
    super.key,
    required this.positionFen,
    required this.movesSans,
    required this.onMove,
    required this.onPromotion,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx2, constraints) {
      final minSize = constraints.maxWidth < constraints.maxHeight
          ? constraints.maxWidth
          : constraints.maxHeight;
      final fontSize = minSize * 0.05;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SimpleChessBoard(
            whitePlayerType: PlayerType.human,
            blackPlayerType: PlayerType.human,
            fen: positionFen,
            onMove: onMove,
            onPromote: onPromotion,
            orientation: BoardColor.white,
            engineThinking: false,
            lastMoveToHighlight: null,
            showCoordinatesZone: true,
          ),
          SizedBox(
            width: fontSize * 0.4,
          ),
          SimpleMovesHistory(
            movesSans: movesSans,
            fontSize: fontSize,
          ),
        ],
      );
    });
  }
}
