import 'dart:math';

import 'package:flutter/material.dart';
import 'package:chess/chess.dart' as chess;
import 'package:simple_chess_board/simple_chess_board.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GameSelectorResult {
  final int gameIndex;

  GameSelectorResult({
    required this.gameIndex,
  });
}

class GameSelectionScreen extends StatefulWidget {
  final dynamic games;

  const GameSelectionScreen({
    super.key,
    required this.games,
  });

  @override
  State<GameSelectionScreen> createState() => _GameSelectionScreenState();
}

class _GameSelectionScreenState extends State<GameSelectionScreen> {
  int _gameIndex = 0;

  gotoFirst() {
    setState(() {
      _gameIndex = 0;
    });
  }

  gotoPrevious() {
    setState(() {
      if (_gameIndex > 0) _gameIndex -= 1;
    });
  }

  gotoNext() {
    setState(() {
      if (_gameIndex < widget.games.length - 1) _gameIndex += 1;
    });
  }

  gotoLast() {
    setState(() {
      _gameIndex = widget.games.length - 1;
    });
  }

  cancel(BuildContext context) {
    Navigator.pop(context);
  }

  validate(BuildContext context) {
    Navigator.pop(
      context,
      GameSelectorResult(
        gameIndex: _gameIndex,
      ),
    );
  }

  resetText() {
    setState(() {});
  }

  tryNavigatingAt(String value) {
    try {
      final gameIndex = int.parse(value) - 1;
      if (gameIndex < 0 || gameIndex > widget.games.length - 1) {
        resetText();
        return;
      }
      setState(() {
        _gameIndex = gameIndex;
      });
    } catch (ex) {
      resetText();
      return;
    }
  }

  bool isBlackTurn() {
    final fen = currentFen();
    final turnString = fen.split(' ')[1];
    return turnString == 'b';
  }

  String currentFen() {
    return (widget.games[_gameIndex]["tags"] ?? {})["FEN"] ?? chess.Chess().fen;
  }

  bool whiteTurnInGameSelector() {
    return currentFen().split(' ')[1] == 'w';
  }

  @override
  Widget build(BuildContext context) {
    final viewport = MediaQuery.of(context).size;
    final size = min(viewport.height * 0.6, viewport.width);
    final fen = currentFen();
    final navigationButtonsSize = size * 0.05;
    final validationButtonsFontSize = size * 0.08;
    final validationButtonsPadding = size * 0.016;
    final navigationFontSize = size * 0.08;

    TextEditingController textController =
        TextEditingController(text: "${_gameIndex + 1}");

    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.game_selector_title),
        ),
        body: Center(
          child: Column(
            children: [
              NavigationProgress(
                fontSize: navigationFontSize,
                gamesCount: widget.games.length,
                indexFieldController: textController,
                indexFieldWidth: size * 0.16,
                onIndexFieldSubmitted: (value) => tryNavigatingAt(value),
              ),
              NavigationZone(
                buttonsSize: navigationButtonsSize,
                onGotoFirst: gotoFirst,
                onGotoNext: gotoNext,
                onGotoLast: gotoLast,
                onGotoPrevious: gotoPrevious,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 9.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      width: size,
                      height: size,
                      child: SimpleChessBoard(
                          fen: fen,
                          orientation: isBlackTurn()
                              ? BoardColor.black
                              : BoardColor.white,
                          whitePlayerType: PlayerType.computer,
                          blackPlayerType: PlayerType.computer,
                          onMove: ({required ShortMove move}) {},
                          onPromote: () async {
                            return null;
                          }),
                    )
                  ],
                ),
              ),
              ValidationZone(
                buttonsFontSize: validationButtonsFontSize,
                buttonsPadding: validationButtonsPadding,
                onCancel: () => cancel(context),
                onValidate: () => validate(context),
              ),
            ],
          ),
        ));
  }
}

class NavigationProgress extends StatelessWidget {
  final double fontSize;
  final int gamesCount;
  final double indexFieldWidth;
  final TextEditingController? indexFieldController;
  final void Function(String)? onIndexFieldSubmitted;

  const NavigationProgress({
    super.key,
    required this.fontSize,
    required this.gamesCount,
    this.indexFieldWidth = 50.0,
    this.indexFieldController,
    this.onIndexFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: indexFieldWidth,
          child: TextField(
            controller: indexFieldController,
            onSubmitted: onIndexFieldSubmitted,
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: fontSize),
          ),
        ),
        Text("/", style: TextStyle(fontSize: fontSize)),
        Text("$gamesCount", style: TextStyle(fontSize: fontSize))
      ],
    );
  }
}

class ValidationZone extends StatelessWidget {
  final double buttonsFontSize;
  final double buttonsPadding;
  final void Function()? onValidate;
  final void Function()? onCancel;

  const ValidationZone({
    super.key,
    this.buttonsFontSize = 18.0,
    this.buttonsPadding = 10.0,
    this.onValidate,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ValidationButton(
          label: AppLocalizations.of(context)!.buttons_cancel,
          fontSize: buttonsFontSize,
          padding: buttonsPadding,
          onPressed: onCancel ?? () {},
          textColor: Colors.red,
        ),
        ValidationButton(
          label: AppLocalizations.of(context)!.buttons_ok,
          fontSize: buttonsFontSize,
          padding: buttonsPadding,
          onPressed: onValidate ?? () {},
          textColor: Colors.blue,
        ),
      ],
    );
  }
}

class ValidationButton extends StatelessWidget {
  final String label;
  final double padding;
  final double fontSize;
  final void Function()? onPressed;
  final Color textColor;

  const ValidationButton({
    super.key,
    required this.label,
    this.fontSize = 18.0,
    this.padding = 10.0,
    this.textColor = Colors.white,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: TextButton(
        style: TextButton.styleFrom(foregroundColor: textColor),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(fontSize: fontSize),
        ),
      ),
    );
  }
}

class NavigationZone extends StatelessWidget {
  final double buttonsSize;
  final void Function() onGotoFirst;
  final void Function() onGotoPrevious;
  final void Function() onGotoNext;
  final void Function() onGotoLast;

  const NavigationZone({
    super.key,
    required this.buttonsSize,
    required this.onGotoFirst,
    required this.onGotoPrevious,
    required this.onGotoNext,
    required this.onGotoLast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        NavigationButton(
          size: buttonsSize,
          imageReference: 'assets/images/first_item.png',
          onPressed: onGotoFirst,
        ),
        NavigationButton(
          size: buttonsSize,
          imageReference: 'assets/images/previous_item.png',
          onPressed: onGotoPrevious,
        ),
        NavigationButton(
          size: buttonsSize,
          imageReference: 'assets/images/next_item.png',
          onPressed: onGotoNext,
        ),
        NavigationButton(
          size: buttonsSize,
          imageReference: 'assets/images/last_item.png',
          onPressed: onGotoLast,
        ),
      ],
    );
  }
}

class NavigationButton extends StatelessWidget {
  final double size;
  final String imageReference;
  final void Function()? onPressed;

  const NavigationButton({
    super.key,
    required this.size,
    required this.imageReference,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: TextButton.icon(
        onPressed: onPressed,
        label: const Text(''),
        icon: Image(
          image: AssetImage(imageReference),
          width: size,
          height: size,
        ),
      ),
    );
  }
}
