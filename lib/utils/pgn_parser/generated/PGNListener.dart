// Generated from PGN.g4 by ANTLR 4.11.1
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes, file_names, non_constant_identifier_names
import 'package:antlr4/antlr4.dart';

import 'PGNParser.dart';

/// This abstract class defines a complete listener for a parse tree produced by
/// [PGNParser].
abstract class PGNListener extends ParseTreeListener {
  /// Enter a parse tree produced by [PGNParser.parse].
  /// [ctx] the parse tree
  void enterParse(ParseContext ctx);

  /// Exit a parse tree produced by [PGNParser.parse].
  /// [ctx] the parse tree
  void exitParse(ParseContext ctx);

  /// Enter a parse tree produced by [PGNParser.pgn_database].
  /// [ctx] the parse tree
  void enterPgn_database(Pgn_databaseContext ctx);

  /// Exit a parse tree produced by [PGNParser.pgn_database].
  /// [ctx] the parse tree
  void exitPgn_database(Pgn_databaseContext ctx);

  /// Enter a parse tree produced by [PGNParser.pgn_game].
  /// [ctx] the parse tree
  void enterPgn_game(Pgn_gameContext ctx);

  /// Exit a parse tree produced by [PGNParser.pgn_game].
  /// [ctx] the parse tree
  void exitPgn_game(Pgn_gameContext ctx);

  /// Enter a parse tree produced by [PGNParser.tag_section].
  /// [ctx] the parse tree
  void enterTag_section(Tag_sectionContext ctx);

  /// Exit a parse tree produced by [PGNParser.tag_section].
  /// [ctx] the parse tree
  void exitTag_section(Tag_sectionContext ctx);

  /// Enter a parse tree produced by [PGNParser.tag_pair].
  /// [ctx] the parse tree
  void enterTag_pair(Tag_pairContext ctx);

  /// Exit a parse tree produced by [PGNParser.tag_pair].
  /// [ctx] the parse tree
  void exitTag_pair(Tag_pairContext ctx);

  /// Enter a parse tree produced by [PGNParser.tag_name].
  /// [ctx] the parse tree
  void enterTag_name(Tag_nameContext ctx);

  /// Exit a parse tree produced by [PGNParser.tag_name].
  /// [ctx] the parse tree
  void exitTag_name(Tag_nameContext ctx);

  /// Enter a parse tree produced by [PGNParser.tag_value].
  /// [ctx] the parse tree
  void enterTag_value(Tag_valueContext ctx);

  /// Exit a parse tree produced by [PGNParser.tag_value].
  /// [ctx] the parse tree
  void exitTag_value(Tag_valueContext ctx);

  /// Enter a parse tree produced by [PGNParser.movetext_section].
  /// [ctx] the parse tree
  void enterMovetext_section(Movetext_sectionContext ctx);

  /// Exit a parse tree produced by [PGNParser.movetext_section].
  /// [ctx] the parse tree
  void exitMovetext_section(Movetext_sectionContext ctx);

  /// Enter a parse tree produced by [PGNParser.element_sequence].
  /// [ctx] the parse tree
  void enterElement_sequence(Element_sequenceContext ctx);

  /// Exit a parse tree produced by [PGNParser.element_sequence].
  /// [ctx] the parse tree
  void exitElement_sequence(Element_sequenceContext ctx);

  /// Enter a parse tree produced by [PGNParser.element].
  /// [ctx] the parse tree
  void enterElement(ElementContext ctx);

  /// Exit a parse tree produced by [PGNParser.element].
  /// [ctx] the parse tree
  void exitElement(ElementContext ctx);

  /// Enter a parse tree produced by [PGNParser.move_number_indication].
  /// [ctx] the parse tree
  void enterMove_number_indication(Move_number_indicationContext ctx);

  /// Exit a parse tree produced by [PGNParser.move_number_indication].
  /// [ctx] the parse tree
  void exitMove_number_indication(Move_number_indicationContext ctx);

  /// Enter a parse tree produced by [PGNParser.san_move].
  /// [ctx] the parse tree
  void enterSan_move(San_moveContext ctx);

  /// Exit a parse tree produced by [PGNParser.san_move].
  /// [ctx] the parse tree
  void exitSan_move(San_moveContext ctx);

  /// Enter a parse tree produced by [PGNParser.recursive_variation].
  /// [ctx] the parse tree
  void enterRecursive_variation(Recursive_variationContext ctx);

  /// Exit a parse tree produced by [PGNParser.recursive_variation].
  /// [ctx] the parse tree
  void exitRecursive_variation(Recursive_variationContext ctx);

  /// Enter a parse tree produced by [PGNParser.game_termination].
  /// [ctx] the parse tree
  void enterGame_termination(Game_terminationContext ctx);

  /// Exit a parse tree produced by [PGNParser.game_termination].
  /// [ctx] the parse tree
  void exitGame_termination(Game_terminationContext ctx);
}
