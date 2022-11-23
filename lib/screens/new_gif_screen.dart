import 'dart:io';

import 'package:antlr4/antlr4.dart';
import 'package:chess_animated_gif_creator/utils/pgn_parser/PGNInterpreter.dart';
import 'package:chess_animated_gif_creator/utils/pgn_parser/generated/PGNLexer.dart';
import 'package:chess_animated_gif_creator/utils/pgn_parser/generated/PGNParser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:file_picker/file_picker.dart';
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

    final content = await selectedFile.readAsString();
    final lexer = PGNLexer(InputStream.fromString(content));
    final tokens = CommonTokenStream(lexer);
    final parser = PGNParser(tokens);
    final tree = parser.parse();

    final walker = ParseTreeWalker();
    final extractor = PgnInterpreter();
    walker.walk(extractor, tree);

    if (extractor.error == null) {
      final allGames = extractor.games;

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
        });
        return;
      }

      final game = allGames[gameData.gameIndex];
      final fen = game.headers["FEN"] ?? chess.Chess().fen;

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
    } else {
      setState(() {
        _isLoading = false;
      });
      if (!mounted) return;
      final snackBar = SnackBar(
        content: Text(
          AppLocalizations.of(context)!.pages_new_gif_failed_loading_pgn,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
