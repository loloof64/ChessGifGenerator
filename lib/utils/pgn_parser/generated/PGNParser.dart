// Generated from PGN.g4 by ANTLR 4.11.1
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes, constant_identifier_names, duplicate_ignore, prefer_function_declarations_over_variables, file_names, non_constant_identifier_names, camel_case_types
import 'package:antlr4/antlr4.dart';

import 'PGNListener.dart';
import 'PGNBaseListener.dart';

// ignore: constant_identifier_names
const int RULE_parse = 0,
    RULE_pgn_database = 1,
    RULE_pgn_game = 2,
    RULE_tag_section = 3,
    RULE_tag_pair = 4,
    RULE_tag_name = 5,
    RULE_tag_value = 6,
    RULE_movetext_section = 7,
    RULE_element_sequence = 8,
    RULE_element = 9,
    RULE_move_number_indication = 10,
    RULE_san_move = 11,
    RULE_recursive_variation = 12,
    RULE_game_termination = 13;

class PGNParser extends Parser {
  static final checkVersion =
      () => RuntimeMetaData.checkVersion('4.11.1', RuntimeMetaData.VERSION);
  static const int TOKEN_EOF = IntStream.EOF;

  static final List<DFA> _decisionToDFA = List.generate(
      _ATN.numberOfDecisions, (i) => DFA(_ATN.getDecisionState(i), i));
  static final PredictionContextCache _sharedContextCache =
      PredictionContextCache();
  static const int TOKEN_WHITE_WINS = 1,
      TOKEN_BLACK_WINS = 2,
      TOKEN_DRAWN_GAME = 3,
      TOKEN_REST_OF_LINE_COMMENT = 4,
      TOKEN_BRACE_COMMENT = 5,
      TOKEN_ESCAPE = 6,
      TOKEN_SPACES = 7,
      TOKEN_STRING = 8,
      TOKEN_INTEGER = 9,
      TOKEN_PERIOD = 10,
      TOKEN_ASTERISK = 11,
      TOKEN_LEFT_BRACKET = 12,
      TOKEN_RIGHT_BRACKET = 13,
      TOKEN_LEFT_PARENTHESIS = 14,
      TOKEN_RIGHT_PARENTHESIS = 15,
      TOKEN_LEFT_ANGLE_BRACKET = 16,
      TOKEN_RIGHT_ANGLE_BRACKET = 17,
      TOKEN_NUMERIC_ANNOTATION_GLYPH = 18,
      TOKEN_SYMBOL = 19,
      TOKEN_SUFFIX_ANNOTATION = 20,
      TOKEN_UNEXPECTED_CHAR = 21;

  @override
  final List<String> ruleNames = [
    'parse',
    'pgn_database',
    'pgn_game',
    'tag_section',
    'tag_pair',
    'tag_name',
    'tag_value',
    'movetext_section',
    'element_sequence',
    'element',
    'move_number_indication',
    'san_move',
    'recursive_variation',
    'game_termination'
  ];

  static final List<String?> _LITERAL_NAMES = [
    null,
    "'1-0'",
    "'0-1'",
    "'1/2-1/2'",
    null,
    null,
    null,
    null,
    null,
    null,
    "'.'",
    "'*'",
    "'['",
    "']'",
    "'('",
    "')'",
    "'<'",
    "'>'"
  ];
  static final List<String?> _SYMBOLIC_NAMES = [
    null,
    "WHITE_WINS",
    "BLACK_WINS",
    "DRAWN_GAME",
    "REST_OF_LINE_COMMENT",
    "BRACE_COMMENT",
    "ESCAPE",
    "SPACES",
    "STRING",
    "INTEGER",
    "PERIOD",
    "ASTERISK",
    "LEFT_BRACKET",
    "RIGHT_BRACKET",
    "LEFT_PARENTHESIS",
    "RIGHT_PARENTHESIS",
    "LEFT_ANGLE_BRACKET",
    "RIGHT_ANGLE_BRACKET",
    "NUMERIC_ANNOTATION_GLYPH",
    "SYMBOL",
    "SUFFIX_ANNOTATION",
    "UNEXPECTED_CHAR"
  ];
  static final Vocabulary VOCABULARY =
      VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

  @override
  Vocabulary get vocabulary {
    return VOCABULARY;
  }

  @override
  String get grammarFileName => 'PGN.g4';

  @override
  List<int> get serializedATN => _serializedATN;

  @override
  ATN getATN() {
    return _ATN;
  }

  PGNParser(TokenStream input) : super(input) {
    interpreter =
        ParserATNSimulator(this, _ATN, _decisionToDFA, _sharedContextCache);
  }

  ParseContext parse() {
    dynamic localctx = ParseContext(context, state);
    enterRule(localctx, 0, RULE_parse);
    try {
      enterOuterAlt(localctx, 1);
      state = 28;
      pgn_database();
      state = 29;
      match(TOKEN_EOF);
    } on RecognitionException catch (re) {
      localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return localctx;
  }

  Pgn_databaseContext pgn_database() {
    dynamic localctx = Pgn_databaseContext(context, state);
    enterRule(localctx, 2, RULE_pgn_database);
    int la;
    try {
      enterOuterAlt(localctx, 1);
      state = 34;
      errorHandler.sync(this);
      la = tokenStream.LA(1)!;
      while (((la) & ~0x3f) == 0 && ((1 << la) & 807424) != 0) {
        state = 31;
        pgn_game();
        state = 36;
        errorHandler.sync(this);
        la = tokenStream.LA(1)!;
      }
    } on RecognitionException catch (re) {
      localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return localctx;
  }

  Pgn_gameContext pgn_game() {
    dynamic localctx = Pgn_gameContext(context, state);
    enterRule(localctx, 4, RULE_pgn_game);
    try {
      enterOuterAlt(localctx, 1);
      state = 37;
      tag_section();
      state = 38;
      movetext_section();
    } on RecognitionException catch (re) {
      localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return localctx;
  }

  Tag_sectionContext tag_section() {
    dynamic localctx = Tag_sectionContext(context, state);
    enterRule(localctx, 6, RULE_tag_section);
    int la;
    try {
      enterOuterAlt(localctx, 1);
      state = 43;
      errorHandler.sync(this);
      la = tokenStream.LA(1)!;
      while (la == TOKEN_LEFT_BRACKET) {
        state = 40;
        tag_pair();
        state = 45;
        errorHandler.sync(this);
        la = tokenStream.LA(1)!;
      }
    } on RecognitionException catch (re) {
      localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return localctx;
  }

  Tag_pairContext tag_pair() {
    dynamic localctx = Tag_pairContext(context, state);
    enterRule(localctx, 8, RULE_tag_pair);
    try {
      enterOuterAlt(localctx, 1);
      state = 46;
      match(TOKEN_LEFT_BRACKET);
      state = 47;
      tag_name();
      state = 48;
      tag_value();
      state = 49;
      match(TOKEN_RIGHT_BRACKET);
    } on RecognitionException catch (re) {
      localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return localctx;
  }

  Tag_nameContext tag_name() {
    dynamic localctx = Tag_nameContext(context, state);
    enterRule(localctx, 10, RULE_tag_name);
    try {
      enterOuterAlt(localctx, 1);
      state = 51;
      match(TOKEN_SYMBOL);
    } on RecognitionException catch (re) {
      localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return localctx;
  }

  Tag_valueContext tag_value() {
    dynamic localctx = Tag_valueContext(context, state);
    enterRule(localctx, 12, RULE_tag_value);
    try {
      enterOuterAlt(localctx, 1);
      state = 53;
      match(TOKEN_STRING);
    } on RecognitionException catch (re) {
      localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return localctx;
  }

  Movetext_sectionContext movetext_section() {
    dynamic localctx = Movetext_sectionContext(context, state);
    enterRule(localctx, 14, RULE_movetext_section);
    int la;
    try {
      enterOuterAlt(localctx, 1);
      state = 55;
      element_sequence();
      state = 57;
      errorHandler.sync(this);
      la = tokenStream.LA(1)!;
      if (((la) & ~0x3f) == 0 && ((1 << la) & 2062) != 0) {
        state = 56;
        game_termination();
      }
    } on RecognitionException catch (re) {
      localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return localctx;
  }

  Element_sequenceContext element_sequence() {
    dynamic localctx = Element_sequenceContext(context, state);
    enterRule(localctx, 16, RULE_element_sequence);
    try {
      int alt;
      enterOuterAlt(localctx, 1);
      state = 61;
      errorHandler.sync(this);
      alt = 1;
      do {
        switch (alt) {
          case 1:
            state = 61;
            errorHandler.sync(this);
            switch (tokenStream.LA(1)!) {
              case TOKEN_INTEGER:
              case TOKEN_NUMERIC_ANNOTATION_GLYPH:
              case TOKEN_SYMBOL:
                state = 59;
                element();
                break;
              case TOKEN_LEFT_PARENTHESIS:
                state = 60;
                recursive_variation();
                break;
              default:
                throw NoViableAltException(this);
            }
            break;
          default:
            throw NoViableAltException(this);
        }
        state = 63;
        errorHandler.sync(this);
        alt = interpreter!.adaptivePredict(tokenStream, 4, context);
      } while (alt != 2 && alt != ATN.INVALID_ALT_NUMBER);
    } on RecognitionException catch (re) {
      localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return localctx;
  }

  ElementContext element() {
    dynamic localctx = ElementContext(context, state);
    enterRule(localctx, 18, RULE_element);
    try {
      state = 68;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
        case TOKEN_INTEGER:
          enterOuterAlt(localctx, 1);
          state = 65;
          move_number_indication();
          break;
        case TOKEN_SYMBOL:
          enterOuterAlt(localctx, 2);
          state = 66;
          san_move();
          break;
        case TOKEN_NUMERIC_ANNOTATION_GLYPH:
          enterOuterAlt(localctx, 3);
          state = 67;
          match(TOKEN_NUMERIC_ANNOTATION_GLYPH);
          break;
        default:
          throw NoViableAltException(this);
      }
    } on RecognitionException catch (re) {
      localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return localctx;
  }

  Move_number_indicationContext move_number_indication() {
    dynamic localctx = Move_number_indicationContext(context, state);
    enterRule(localctx, 20, RULE_move_number_indication);
    int la;
    try {
      enterOuterAlt(localctx, 1);
      state = 70;
      match(TOKEN_INTEGER);
      state = 72;
      errorHandler.sync(this);
      la = tokenStream.LA(1)!;
      do {
        state = 71;
        match(TOKEN_PERIOD);
        state = 74;
        errorHandler.sync(this);
        la = tokenStream.LA(1)!;
      } while (la == TOKEN_PERIOD);
    } on RecognitionException catch (re) {
      localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return localctx;
  }

  San_moveContext san_move() {
    dynamic localctx = San_moveContext(context, state);
    enterRule(localctx, 22, RULE_san_move);
    try {
      enterOuterAlt(localctx, 1);
      state = 76;
      match(TOKEN_SYMBOL);
    } on RecognitionException catch (re) {
      localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return localctx;
  }

  Recursive_variationContext recursive_variation() {
    dynamic localctx = Recursive_variationContext(context, state);
    enterRule(localctx, 24, RULE_recursive_variation);
    try {
      enterOuterAlt(localctx, 1);
      state = 78;
      match(TOKEN_LEFT_PARENTHESIS);
      state = 79;
      element_sequence();
      state = 80;
      match(TOKEN_RIGHT_PARENTHESIS);
    } on RecognitionException catch (re) {
      localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return localctx;
  }

  Game_terminationContext game_termination() {
    dynamic localctx = Game_terminationContext(context, state);
    enterRule(localctx, 26, RULE_game_termination);
    int la;
    try {
      enterOuterAlt(localctx, 1);
      state = 82;
      la = tokenStream.LA(1)!;
      if (!(((la) & ~0x3f) == 0 && ((1 << la) & 2062) != 0)) {
        errorHandler.recoverInline(this);
      } else {
        if (tokenStream.LA(1)! == IntStream.EOF) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
    } on RecognitionException catch (re) {
      localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return localctx;
  }

  static const List<int> _serializedATN = [
    4,
    1,
    21,
    85,
    2,
    0,
    7,
    0,
    2,
    1,
    7,
    1,
    2,
    2,
    7,
    2,
    2,
    3,
    7,
    3,
    2,
    4,
    7,
    4,
    2,
    5,
    7,
    5,
    2,
    6,
    7,
    6,
    2,
    7,
    7,
    7,
    2,
    8,
    7,
    8,
    2,
    9,
    7,
    9,
    2,
    10,
    7,
    10,
    2,
    11,
    7,
    11,
    2,
    12,
    7,
    12,
    2,
    13,
    7,
    13,
    1,
    0,
    1,
    0,
    1,
    0,
    1,
    1,
    5,
    1,
    33,
    8,
    1,
    10,
    1,
    12,
    1,
    36,
    9,
    1,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    3,
    5,
    3,
    42,
    8,
    3,
    10,
    3,
    12,
    3,
    45,
    9,
    3,
    1,
    4,
    1,
    4,
    1,
    4,
    1,
    4,
    1,
    4,
    1,
    5,
    1,
    5,
    1,
    6,
    1,
    6,
    1,
    7,
    1,
    7,
    3,
    7,
    58,
    8,
    7,
    1,
    8,
    1,
    8,
    4,
    8,
    62,
    8,
    8,
    11,
    8,
    12,
    8,
    63,
    1,
    9,
    1,
    9,
    1,
    9,
    3,
    9,
    69,
    8,
    9,
    1,
    10,
    1,
    10,
    4,
    10,
    73,
    8,
    10,
    11,
    10,
    12,
    10,
    74,
    1,
    11,
    1,
    11,
    1,
    12,
    1,
    12,
    1,
    12,
    1,
    12,
    1,
    13,
    1,
    13,
    1,
    13,
    0,
    0,
    14,
    0,
    2,
    4,
    6,
    8,
    10,
    12,
    14,
    16,
    18,
    20,
    22,
    24,
    26,
    0,
    1,
    2,
    0,
    1,
    3,
    11,
    11,
    78,
    0,
    28,
    1,
    0,
    0,
    0,
    2,
    34,
    1,
    0,
    0,
    0,
    4,
    37,
    1,
    0,
    0,
    0,
    6,
    43,
    1,
    0,
    0,
    0,
    8,
    46,
    1,
    0,
    0,
    0,
    10,
    51,
    1,
    0,
    0,
    0,
    12,
    53,
    1,
    0,
    0,
    0,
    14,
    55,
    1,
    0,
    0,
    0,
    16,
    61,
    1,
    0,
    0,
    0,
    18,
    68,
    1,
    0,
    0,
    0,
    20,
    70,
    1,
    0,
    0,
    0,
    22,
    76,
    1,
    0,
    0,
    0,
    24,
    78,
    1,
    0,
    0,
    0,
    26,
    82,
    1,
    0,
    0,
    0,
    28,
    29,
    3,
    2,
    1,
    0,
    29,
    30,
    5,
    0,
    0,
    1,
    30,
    1,
    1,
    0,
    0,
    0,
    31,
    33,
    3,
    4,
    2,
    0,
    32,
    31,
    1,
    0,
    0,
    0,
    33,
    36,
    1,
    0,
    0,
    0,
    34,
    32,
    1,
    0,
    0,
    0,
    34,
    35,
    1,
    0,
    0,
    0,
    35,
    3,
    1,
    0,
    0,
    0,
    36,
    34,
    1,
    0,
    0,
    0,
    37,
    38,
    3,
    6,
    3,
    0,
    38,
    39,
    3,
    14,
    7,
    0,
    39,
    5,
    1,
    0,
    0,
    0,
    40,
    42,
    3,
    8,
    4,
    0,
    41,
    40,
    1,
    0,
    0,
    0,
    42,
    45,
    1,
    0,
    0,
    0,
    43,
    41,
    1,
    0,
    0,
    0,
    43,
    44,
    1,
    0,
    0,
    0,
    44,
    7,
    1,
    0,
    0,
    0,
    45,
    43,
    1,
    0,
    0,
    0,
    46,
    47,
    5,
    12,
    0,
    0,
    47,
    48,
    3,
    10,
    5,
    0,
    48,
    49,
    3,
    12,
    6,
    0,
    49,
    50,
    5,
    13,
    0,
    0,
    50,
    9,
    1,
    0,
    0,
    0,
    51,
    52,
    5,
    19,
    0,
    0,
    52,
    11,
    1,
    0,
    0,
    0,
    53,
    54,
    5,
    8,
    0,
    0,
    54,
    13,
    1,
    0,
    0,
    0,
    55,
    57,
    3,
    16,
    8,
    0,
    56,
    58,
    3,
    26,
    13,
    0,
    57,
    56,
    1,
    0,
    0,
    0,
    57,
    58,
    1,
    0,
    0,
    0,
    58,
    15,
    1,
    0,
    0,
    0,
    59,
    62,
    3,
    18,
    9,
    0,
    60,
    62,
    3,
    24,
    12,
    0,
    61,
    59,
    1,
    0,
    0,
    0,
    61,
    60,
    1,
    0,
    0,
    0,
    62,
    63,
    1,
    0,
    0,
    0,
    63,
    61,
    1,
    0,
    0,
    0,
    63,
    64,
    1,
    0,
    0,
    0,
    64,
    17,
    1,
    0,
    0,
    0,
    65,
    69,
    3,
    20,
    10,
    0,
    66,
    69,
    3,
    22,
    11,
    0,
    67,
    69,
    5,
    18,
    0,
    0,
    68,
    65,
    1,
    0,
    0,
    0,
    68,
    66,
    1,
    0,
    0,
    0,
    68,
    67,
    1,
    0,
    0,
    0,
    69,
    19,
    1,
    0,
    0,
    0,
    70,
    72,
    5,
    9,
    0,
    0,
    71,
    73,
    5,
    10,
    0,
    0,
    72,
    71,
    1,
    0,
    0,
    0,
    73,
    74,
    1,
    0,
    0,
    0,
    74,
    72,
    1,
    0,
    0,
    0,
    74,
    75,
    1,
    0,
    0,
    0,
    75,
    21,
    1,
    0,
    0,
    0,
    76,
    77,
    5,
    19,
    0,
    0,
    77,
    23,
    1,
    0,
    0,
    0,
    78,
    79,
    5,
    14,
    0,
    0,
    79,
    80,
    3,
    16,
    8,
    0,
    80,
    81,
    5,
    15,
    0,
    0,
    81,
    25,
    1,
    0,
    0,
    0,
    82,
    83,
    7,
    0,
    0,
    0,
    83,
    27,
    1,
    0,
    0,
    0,
    7,
    34,
    43,
    57,
    61,
    63,
    68,
    74
  ];

  static final ATN _ATN = ATNDeserializer().deserialize(_serializedATN);
}

class ParseContext extends ParserRuleContext {
  Pgn_databaseContext? pgn_database() => getRuleContext<Pgn_databaseContext>(0);
  TerminalNode? EOF() => getToken(PGNParser.TOKEN_EOF, 0);
  ParseContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_parse;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.enterParse(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.exitParse(this);
  }
}

class Pgn_databaseContext extends ParserRuleContext {
  List<Pgn_gameContext> pgn_games() => getRuleContexts<Pgn_gameContext>();
  Pgn_gameContext? pgn_game(int i) => getRuleContext<Pgn_gameContext>(i);
  Pgn_databaseContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_pgn_database;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.enterPgn_database(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.exitPgn_database(this);
  }
}

class Pgn_gameContext extends ParserRuleContext {
  Tag_sectionContext? tag_section() => getRuleContext<Tag_sectionContext>(0);
  Movetext_sectionContext? movetext_section() =>
      getRuleContext<Movetext_sectionContext>(0);
  Pgn_gameContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_pgn_game;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.enterPgn_game(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.exitPgn_game(this);
  }
}

class Tag_sectionContext extends ParserRuleContext {
  List<Tag_pairContext> tag_pairs() => getRuleContexts<Tag_pairContext>();
  Tag_pairContext? tag_pair(int i) => getRuleContext<Tag_pairContext>(i);
  Tag_sectionContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_tag_section;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.enterTag_section(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.exitTag_section(this);
  }
}

class Tag_pairContext extends ParserRuleContext {
  TerminalNode? LEFT_BRACKET() => getToken(PGNParser.TOKEN_LEFT_BRACKET, 0);
  Tag_nameContext? tag_name() => getRuleContext<Tag_nameContext>(0);
  Tag_valueContext? tag_value() => getRuleContext<Tag_valueContext>(0);
  TerminalNode? RIGHT_BRACKET() => getToken(PGNParser.TOKEN_RIGHT_BRACKET, 0);
  Tag_pairContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_tag_pair;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.enterTag_pair(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.exitTag_pair(this);
  }
}

class Tag_nameContext extends ParserRuleContext {
  TerminalNode? SYMBOL() => getToken(PGNParser.TOKEN_SYMBOL, 0);
  Tag_nameContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_tag_name;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.enterTag_name(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.exitTag_name(this);
  }
}

class Tag_valueContext extends ParserRuleContext {
  TerminalNode? STRING() => getToken(PGNParser.TOKEN_STRING, 0);
  Tag_valueContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_tag_value;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.enterTag_value(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.exitTag_value(this);
  }
}

class Movetext_sectionContext extends ParserRuleContext {
  Element_sequenceContext? element_sequence() =>
      getRuleContext<Element_sequenceContext>(0);
  Game_terminationContext? game_termination() =>
      getRuleContext<Game_terminationContext>(0);
  Movetext_sectionContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_movetext_section;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.enterMovetext_section(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.exitMovetext_section(this);
  }
}

class Element_sequenceContext extends ParserRuleContext {
  List<ElementContext> elements() => getRuleContexts<ElementContext>();
  ElementContext? element(int i) => getRuleContext<ElementContext>(i);
  List<Recursive_variationContext> recursive_variations() =>
      getRuleContexts<Recursive_variationContext>();
  Recursive_variationContext? recursive_variation(int i) =>
      getRuleContext<Recursive_variationContext>(i);
  Element_sequenceContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_element_sequence;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.enterElement_sequence(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.exitElement_sequence(this);
  }
}

class ElementContext extends ParserRuleContext {
  Move_number_indicationContext? move_number_indication() =>
      getRuleContext<Move_number_indicationContext>(0);
  San_moveContext? san_move() => getRuleContext<San_moveContext>(0);
  TerminalNode? NUMERIC_ANNOTATION_GLYPH() =>
      getToken(PGNParser.TOKEN_NUMERIC_ANNOTATION_GLYPH, 0);
  ElementContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_element;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.enterElement(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.exitElement(this);
  }
}

class Move_number_indicationContext extends ParserRuleContext {
  TerminalNode? INTEGER() => getToken(PGNParser.TOKEN_INTEGER, 0);
  List<TerminalNode> PERIODs() => getTokens(PGNParser.TOKEN_PERIOD);
  TerminalNode? PERIOD(int i) => getToken(PGNParser.TOKEN_PERIOD, i);
  Move_number_indicationContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_move_number_indication;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.enterMove_number_indication(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.exitMove_number_indication(this);
  }
}

class San_moveContext extends ParserRuleContext {
  TerminalNode? SYMBOL() => getToken(PGNParser.TOKEN_SYMBOL, 0);
  San_moveContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_san_move;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.enterSan_move(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.exitSan_move(this);
  }
}

class Recursive_variationContext extends ParserRuleContext {
  TerminalNode? LEFT_PARENTHESIS() =>
      getToken(PGNParser.TOKEN_LEFT_PARENTHESIS, 0);
  Element_sequenceContext? element_sequence() =>
      getRuleContext<Element_sequenceContext>(0);
  TerminalNode? RIGHT_PARENTHESIS() =>
      getToken(PGNParser.TOKEN_RIGHT_PARENTHESIS, 0);
  Recursive_variationContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_recursive_variation;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.enterRecursive_variation(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.exitRecursive_variation(this);
  }
}

class Game_terminationContext extends ParserRuleContext {
  TerminalNode? WHITE_WINS() => getToken(PGNParser.TOKEN_WHITE_WINS, 0);
  TerminalNode? BLACK_WINS() => getToken(PGNParser.TOKEN_BLACK_WINS, 0);
  TerminalNode? DRAWN_GAME() => getToken(PGNParser.TOKEN_DRAWN_GAME, 0);
  TerminalNode? ASTERISK() => getToken(PGNParser.TOKEN_ASTERISK, 0);
  Game_terminationContext([ParserRuleContext? parent, int? invokingState])
      : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_game_termination;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.enterGame_termination(this);
  }

  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is PGNListener) listener.exitGame_termination(this);
  }
}
