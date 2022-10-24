import 'dart:io';

import 'package:chess_animated_gif_creator/utils/pgn_parser/pgn_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:file_picker/file_picker.dart';
import 'package:petitparser/petitparser.dart';
import 'package:chess/chess.dart' as chess;

import '../screens/game_selection_screen.dart';
import '../screens/gif_edition_screen.dart';

class NewGifScreen extends StatefulWidget {
  const NewGifScreen({super.key});

  @override
  State<NewGifScreen> createState() => _NewGifScreenState();
}

class _NewGifScreenState extends State<NewGifScreen> {
  bool _isLoading = false;

  Future<void> _letUserEditGif() async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const GifEditionScreen(),
    ));
  }

  Future<void> _letUserChoosePgn() async {
    if (!mounted) return;
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pgn'],
    );
    if (result == null) return;

    setState(() {
      _isLoading = true;
    });

    final selectedFile = File(result.files.single.path!);

    try {
      final content = await selectedFile.readAsString();
      final definition = PgnParserDefinition();
      final parser = definition.build();
      final parserResult = parser.parse(content);

      final tempValue = parserResult.value;
      final allGames = tempValue is List && tempValue[0] is Failure<dynamic>
          ? tempValue.last
          : tempValue;

      if (!mounted) return;
      final gameData = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => GameSelectionScreen(games: allGames),
        ),
      );
      final userCancellation = gameData == null;
      if (userCancellation) {
        setState(() {
          _isLoading = false;
        }); // TODO show error snackbar
        return;
      }

      final game = allGames[gameData.gameIndex];
      final fen = (game["tags"] ?? {})["FEN"] ?? chess.Chess().fen;

      final gameLogic = chess.Chess.fromFEN(fen);
      final moves = gameLogic.generate_moves();
      final noMoreMove = moves.isEmpty;

      if (noMoreMove) {
        if (!mounted) return;
        throw Exception(AppLocalizations.of(context)?.no_move_in_selected_game);
      }

      if (!mounted) return;
      await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => GifEditionScreen(game: game),
      ));
    } catch (ex) {
      setState(() {
        _isLoading = false;
      });
      // TODO show error snackbar
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.pages_new_gif_title,
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _letUserEditGif,
                  child: Text(
                    AppLocalizations.of(context)!
                        .pages_new_gif_buttons_manual_creation,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed: _letUserChoosePgn,
                  child: Text(
                    AppLocalizations.of(context)!
                        .pages_new_gif_buttons_creation_from_pgn,
                  ),
                )
              ],
            ),
          ),
          if (_isLoading)
            LayoutBuilder(builder: (ctx2, constraints2) {
              final minSize = constraints2.maxWidth < constraints2.maxHeight
                  ? constraints2.maxWidth
                  : constraints2.maxHeight;
              return Center(
                child: SizedBox(
                  width: minSize * 0.6,
                  height: minSize * 0.6,
                  child: const CircularProgressIndicator(
                    strokeWidth: 5.0,
                    color: Colors.blue,
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}
