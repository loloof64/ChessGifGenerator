// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names

import 'package:antlr4/antlr4.dart';

import 'package:chess_animated_gif_creator/utils/pgn_parser/generated/PGNBaseListener.dart';
import 'package:chess_animated_gif_creator/utils/pgn_parser/generated/PGNParser.dart';

class PgnGameMove {
  final int moveNumber;
  final String moveSan;
  final bool whiteMove;

  PgnGameMove(this.moveNumber, this.moveSan, this.whiteMove);

  @override
  String toString() =>
      'PgnGameMove(moveNumber: $moveNumber, moveSan: $moveSan, whiteMove: $whiteMove)';
}

class PgnGame {
  final Map<String, String> headers;
  final List<PgnGameMove> moves;
  final PgnGameTermination termination;

  PgnGame(this.headers, this.moves, this.termination);

  @override
  String toString() =>
      'PgnGame(headers: $headers, moves: $moves, termination: $termination)';
}

enum PgnGameTermination {
  unknown,
  whiteWin,
  blackWin,
  draw,
}

class PgnInterpreter extends PGNBaseListener {
  final List<PgnGame> _games = <PgnGame>[];
  String? _error;
  int? _currentMoveNumber;
  bool? _isWhiteTurn;
  String? _moveSan;
  PgnGameTermination _termination = PgnGameTermination.unknown;

  Map<String, String> _headers = {};
  List<PgnGameMove> _moves = [];

  List<PgnGame> get games => _games;
  String? get error => _error;

  @override
  void visitErrorNode(ErrorNode node) {
    _error = node.text;
  }

  @override
  // ignore: non_constant_identifier_names
  void enterPgn_game(Pgn_gameContext ctx) {
    _headers = {};
    _moves = [];
    _termination = PgnGameTermination.unknown;
  }

  @override
  // ignore: non_constant_identifier_names
  void exitPgn_game(Pgn_gameContext ctx) {
    _games.add(PgnGame(_headers, _moves, _termination));
  }

  @override
  // ignore: non_constant_identifier_names
  void exitTag_pair(Tag_pairContext ctx) {
    final key = ctx.tag_name()?.text;
    final value = ctx.tag_value()?.text ?? '';

    if (key != null) {
      _headers[key] = value;
    }
  }

  @override
  // ignore: non_constant_identifier_names
  void exitMove_number_indication(Move_number_indicationContext ctx) {
    final number = ctx.INTEGER()?.text ?? "";
    _currentMoveNumber = int.parse(number);
    final periodsCount = ctx.PERIODs().length;
    _isWhiteTurn = periodsCount <= 1;
  }

  @override
  // ignore: non_constant_identifier_names
  void exitSan_move(San_moveContext ctx) {
    _moveSan = ctx.SYMBOL()?.text;
    final currentIsWhiteTurnValue = _isWhiteTurn!;

    _moves.add(PgnGameMove(_currentMoveNumber!, _moveSan!, _isWhiteTurn!));
    _isWhiteTurn = !currentIsWhiteTurnValue;
  }

  @override
  // ignore: non_constant_identifier_names
  void exitGame_termination(Game_terminationContext ctx) {
    if (ctx.WHITE_WINS() != null) {
      _termination = PgnGameTermination.whiteWin;
    } else if (ctx.BLACK_WINS() != null) {
      _termination = PgnGameTermination.blackWin;
    } else if (ctx.DRAWN_GAME() != null) {
      _termination = PgnGameTermination.draw;
    } else {
      _termination = PgnGameTermination.unknown;
    }
  }
}
