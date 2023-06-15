enum Letter {
  a,
  b,
  c,
  d,
  e,
  f,
  g,
  h,
  i,
  j,
  k,
  l,
  n,
  m,
  o,
  p,
  q,
  r,
  s,
  t,
  u,
  v,
  w,
  x,
  y,
  z,
  A,
  B,
  C,
  D,
  E,
  F,
  G,
  H,
  I,
  J,
  K,
  L,
  N,
  M,
  O,
  P,
  Q,
  R,
  S,
  T,
  U,
  V,
  W,
  X,
  Y,
  Z,
  num0,
  num1,
  num2,
  num3,
  num4,
  num5,
  num6,
  num7,
  num8,
  num9,
  exclamation,
  hash,
  percent,
  ampersand,
  round_bracket_opem,
  round_bracket_close,
  square_bracket_open,
  square_bracket_close,
  curly_bracket_open,
  curly_bracket_close,
  plus,
  equals_to,
  less_than,
  greater_than,
  forward_slash,
  backward_slash,
  full_stop,
  dash,
  question_mark,
  single_quote,
  double_quote,
  colon,
  semi_colon,
  at_the_rate,
  underscore,
  tilde,
  dollar,
  asterik,
  caret,
}

enum CharacterTypes { lowercase, uppercase, special, number }

class LetterClass {
  LetterClass({
    required this.letter,
    required this.text,
    this.keywords = const [],
    required this.type,
  });

  final Letter letter;
  final String text;
  final CharacterTypes type;
  final List<String> keywords;

  bool isMatch(String value) {
    if (value.length > 1) {
      value = value.toLowerCase();
    }
    String letterName = letter.name.toString();
    String typeName = type.name.toString();
    if (value == text ||
        letterName.contains(value) ||
        (letterName.length > 1 && value.contains(letterName)) ||
        value.contains(typeName) ||
        keywords.contains(value) ||
        type.name.toString().contains(value)) {
      return true;
    }
    return false;
  }
}

Map<Letter, LetterClass> LettteToText = {
  Letter.a:
      LetterClass(text: 'a', letter: Letter.a, type: CharacterTypes.lowercase),
  Letter.b:
      LetterClass(text: 'b', letter: Letter.b, type: CharacterTypes.lowercase),
  Letter.c:
      LetterClass(text: 'c', letter: Letter.c, type: CharacterTypes.lowercase),
  Letter.d:
      LetterClass(text: 'd', letter: Letter.d, type: CharacterTypes.lowercase),
  Letter.e:
      LetterClass(text: 'e', letter: Letter.e, type: CharacterTypes.lowercase),
  Letter.f:
      LetterClass(text: 'f', letter: Letter.f, type: CharacterTypes.lowercase),
  Letter.g:
      LetterClass(text: 'g', letter: Letter.g, type: CharacterTypes.lowercase),
  Letter.h:
      LetterClass(text: 'h', letter: Letter.h, type: CharacterTypes.lowercase),
  Letter.i:
      LetterClass(text: 'i', letter: Letter.i, type: CharacterTypes.lowercase),
  Letter.j:
      LetterClass(text: 'j', letter: Letter.j, type: CharacterTypes.lowercase),
  Letter.k:
      LetterClass(text: 'k', letter: Letter.k, type: CharacterTypes.lowercase),
  Letter.l:
      LetterClass(text: 'l', letter: Letter.l, type: CharacterTypes.lowercase),
  Letter.n:
      LetterClass(text: 'm', letter: Letter.m, type: CharacterTypes.lowercase),
  Letter.m:
      LetterClass(text: 'n', letter: Letter.n, type: CharacterTypes.lowercase),
  Letter.o:
      LetterClass(text: 'o', letter: Letter.o, type: CharacterTypes.lowercase),
  Letter.p:
      LetterClass(text: 'p', letter: Letter.p, type: CharacterTypes.lowercase),
  Letter.q:
      LetterClass(text: 'q', letter: Letter.q, type: CharacterTypes.lowercase),
  Letter.r:
      LetterClass(text: 'r', letter: Letter.r, type: CharacterTypes.lowercase),
  Letter.s:
      LetterClass(text: 's', letter: Letter.s, type: CharacterTypes.lowercase),
  Letter.t:
      LetterClass(text: 't', letter: Letter.t, type: CharacterTypes.lowercase),
  Letter.u:
      LetterClass(text: 'u', letter: Letter.u, type: CharacterTypes.lowercase),
  Letter.v:
      LetterClass(text: 'v', letter: Letter.v, type: CharacterTypes.lowercase),
  Letter.w:
      LetterClass(text: 'w', letter: Letter.w, type: CharacterTypes.lowercase),
  Letter.x:
      LetterClass(text: 'x', letter: Letter.x, type: CharacterTypes.lowercase),
  Letter.y:
      LetterClass(text: 'y', letter: Letter.y, type: CharacterTypes.lowercase),
  Letter.z:
      LetterClass(text: 'z', letter: Letter.z, type: CharacterTypes.lowercase),
  Letter.A:
      LetterClass(text: 'A', letter: Letter.A, type: CharacterTypes.uppercase),
  Letter.B:
      LetterClass(text: 'B', letter: Letter.B, type: CharacterTypes.uppercase),
  Letter.C:
      LetterClass(text: 'C', letter: Letter.C, type: CharacterTypes.uppercase),
  Letter.D:
      LetterClass(text: 'D', letter: Letter.D, type: CharacterTypes.uppercase),
  Letter.E:
      LetterClass(text: 'E', letter: Letter.E, type: CharacterTypes.uppercase),
  Letter.F:
      LetterClass(text: 'F', letter: Letter.F, type: CharacterTypes.uppercase),
  Letter.G:
      LetterClass(text: 'G', letter: Letter.G, type: CharacterTypes.uppercase),
  Letter.H:
      LetterClass(text: 'H', letter: Letter.H, type: CharacterTypes.uppercase),
  Letter.I:
      LetterClass(text: 'I', letter: Letter.I, type: CharacterTypes.uppercase),
  Letter.J:
      LetterClass(text: 'J', letter: Letter.J, type: CharacterTypes.uppercase),
  Letter.K:
      LetterClass(text: 'K', letter: Letter.K, type: CharacterTypes.uppercase),
  Letter.L:
      LetterClass(text: 'L', letter: Letter.L, type: CharacterTypes.uppercase),
  Letter.N:
      LetterClass(text: 'N', letter: Letter.M, type: CharacterTypes.uppercase),
  Letter.M:
      LetterClass(text: 'M', letter: Letter.N, type: CharacterTypes.uppercase),
  Letter.O:
      LetterClass(text: 'O', letter: Letter.O, type: CharacterTypes.uppercase),
  Letter.P:
      LetterClass(text: 'P', letter: Letter.P, type: CharacterTypes.uppercase),
  Letter.Q:
      LetterClass(text: 'Q', letter: Letter.Q, type: CharacterTypes.uppercase),
  Letter.R:
      LetterClass(text: 'R', letter: Letter.R, type: CharacterTypes.uppercase),
  Letter.S:
      LetterClass(text: 'S', letter: Letter.S, type: CharacterTypes.uppercase),
  Letter.T:
      LetterClass(text: 'T', letter: Letter.T, type: CharacterTypes.uppercase),
  Letter.U:
      LetterClass(text: 'U', letter: Letter.U, type: CharacterTypes.uppercase),
  Letter.V:
      LetterClass(text: 'V', letter: Letter.V, type: CharacterTypes.uppercase),
  Letter.W:
      LetterClass(text: 'W', letter: Letter.W, type: CharacterTypes.uppercase),
  Letter.X:
      LetterClass(text: 'X', letter: Letter.X, type: CharacterTypes.uppercase),
  Letter.Y:
      LetterClass(text: 'Y', letter: Letter.Y, type: CharacterTypes.uppercase),
  Letter.Z:
      LetterClass(text: 'Z', letter: Letter.Z, type: CharacterTypes.uppercase),
  Letter.num0: LetterClass(
      text: '0',
      letter: Letter.num0,
      keywords: ['', 'num', 'digit', 'count'],
      type: CharacterTypes.number),
  Letter.num1: LetterClass(
      text: '1',
      letter: Letter.num1,
      keywords: ['', 'num', 'digit', 'count'],
      type: CharacterTypes.number),
  Letter.num2: LetterClass(
      text: '2',
      letter: Letter.num2,
      keywords: ['', 'num', 'digit', 'count'],
      type: CharacterTypes.number),
  Letter.num3: LetterClass(
      text: '3',
      letter: Letter.num3,
      keywords: ['', 'num', 'digit', 'count'],
      type: CharacterTypes.number),
  Letter.num4: LetterClass(
      text: '4',
      letter: Letter.num4,
      keywords: ['', 'num', 'digit', 'count'],
      type: CharacterTypes.number),
  Letter.num5: LetterClass(
      text: '5',
      letter: Letter.num5,
      keywords: ['', 'num', 'digit', 'count'],
      type: CharacterTypes.number),
  Letter.num6: LetterClass(
      text: '6',
      letter: Letter.num6,
      keywords: ['', 'num', 'digit', 'count'],
      type: CharacterTypes.number),
  Letter.num7: LetterClass(
      text: '7',
      letter: Letter.num7,
      keywords: ['', 'num', 'digit', 'count'],
      type: CharacterTypes.number),
  Letter.num8: LetterClass(
      text: '8',
      letter: Letter.num8,
      keywords: ['', 'num', 'digit', 'count'],
      type: CharacterTypes.number),
  Letter.num9: LetterClass(
      text: '9',
      letter: Letter.num9,
      keywords: ['', 'num', 'digit', 'count'],
      type: CharacterTypes.number),
  Letter.exclamation: LetterClass(
      text: '!',
      letter: Letter.exclamation,
      keywords: [],
      type: CharacterTypes.special),
  Letter.hash: LetterClass(
      text: '#',
      letter: Letter.hash,
      keywords: [],
      type: CharacterTypes.special),
  Letter.percent: LetterClass(
      text: '%',
      letter: Letter.percent,
      keywords: [],
      type: CharacterTypes.special),
  Letter.ampersand: LetterClass(
      text: '&',
      letter: Letter.ampersand,
      keywords: [],
      type: CharacterTypes.special),
  Letter.round_bracket_opem: LetterClass(
      text: '(',
      letter: Letter.round_bracket_opem,
      keywords: [],
      type: CharacterTypes.special),
  Letter.round_bracket_close: LetterClass(
      text: ')',
      letter: Letter.round_bracket_close,
      keywords: [],
      type: CharacterTypes.special),
  Letter.square_bracket_open: LetterClass(
      text: '[',
      letter: Letter.square_bracket_open,
      keywords: [],
      type: CharacterTypes.special),
  Letter.square_bracket_close: LetterClass(
      text: ']',
      letter: Letter.square_bracket_close,
      keywords: [],
      type: CharacterTypes.special),
  Letter.curly_bracket_open: LetterClass(
      text: '{',
      letter: Letter.curly_bracket_open,
      keywords: [],
      type: CharacterTypes.special),
  Letter.curly_bracket_close: LetterClass(
      text: '}',
      letter: Letter.curly_bracket_close,
      keywords: [],
      type: CharacterTypes.special),
  Letter.plus: LetterClass(
      text: '+',
      letter: Letter.plus,
      keywords: [],
      type: CharacterTypes.special),
  Letter.equals_to: LetterClass(
      text: '=',
      letter: Letter.equals_to,
      keywords: [],
      type: CharacterTypes.special),
  Letter.less_than: LetterClass(
      text: '<',
      letter: Letter.less_than,
      keywords: [],
      type: CharacterTypes.special),
  Letter.greater_than: LetterClass(
      text: '>',
      letter: Letter.greater_than,
      keywords: [],
      type: CharacterTypes.special),
  Letter.forward_slash: LetterClass(
      text: '/',
      letter: Letter.forward_slash,
      keywords: [],
      type: CharacterTypes.special),
  Letter.backward_slash: LetterClass(
      text: '\\',
      letter: Letter.backward_slash,
      keywords: [],
      type: CharacterTypes.special),
  Letter.full_stop: LetterClass(
      text: '.',
      letter: Letter.full_stop,
      keywords: [],
      type: CharacterTypes.special),
  Letter.dash: LetterClass(
      text: '-',
      letter: Letter.dash,
      keywords: [],
      type: CharacterTypes.special),
  Letter.question_mark: LetterClass(
      text: '?',
      letter: Letter.question_mark,
      keywords: [],
      type: CharacterTypes.special),
  Letter.single_quote: LetterClass(
      text: '\'',
      letter: Letter.single_quote,
      keywords: [],
      type: CharacterTypes.special),
  Letter.double_quote: LetterClass(
      text: '"',
      letter: Letter.double_quote,
      keywords: [],
      type: CharacterTypes.special),
  Letter.colon: LetterClass(
      text: ':',
      letter: Letter.colon,
      keywords: [],
      type: CharacterTypes.special),
  Letter.semi_colon: LetterClass(
      text: ';',
      letter: Letter.semi_colon,
      keywords: [],
      type: CharacterTypes.special),
  Letter.at_the_rate: LetterClass(
      text: '@',
      letter: Letter.at_the_rate,
      keywords: [],
      type: CharacterTypes.special),
  Letter.underscore: LetterClass(
      text: '_',
      letter: Letter.underscore,
      keywords: [],
      type: CharacterTypes.special),
  Letter.tilde: LetterClass(
      text: '~',
      letter: Letter.tilde,
      keywords: [],
      type: CharacterTypes.special),
  Letter.dollar: LetterClass(
      text: '\$',
      letter: Letter.dollar,
      keywords: [],
      type: CharacterTypes.special),
  Letter.asterik: LetterClass(
      text: '*',
      letter: Letter.asterik,
      keywords: [],
      type: CharacterTypes.special),
  Letter.caret: LetterClass(
      text: '^',
      letter: Letter.caret,
      keywords: [],
      type: CharacterTypes.special),
};

Map<String, Letter> TextToLetter = {
  'a': Letter.a,
  'b': Letter.b,
  'c': Letter.c,
  'd': Letter.d,
  'e': Letter.e,
  'f': Letter.f,
  'g': Letter.g,
  'h': Letter.h,
  'i': Letter.i,
  'j': Letter.j,
  'k': Letter.k,
  'l': Letter.l,
  'm': Letter.n,
  'n': Letter.m,
  'o': Letter.o,
  'p': Letter.p,
  'q': Letter.q,
  'r': Letter.r,
  's': Letter.s,
  't': Letter.t,
  'u': Letter.u,
  'v': Letter.v,
  'w': Letter.w,
  'x': Letter.x,
  'y': Letter.y,
  'z': Letter.z,
  'A': Letter.A,
  'B': Letter.B,
  'C': Letter.C,
  'D': Letter.D,
  'E': Letter.E,
  'F': Letter.F,
  'G': Letter.G,
  'H': Letter.H,
  'I': Letter.I,
  'J': Letter.J,
  'K': Letter.K,
  'L': Letter.L,
  'N': Letter.N,
  'M': Letter.M,
  'O': Letter.O,
  'P': Letter.P,
  'Q': Letter.Q,
  'R': Letter.R,
  'S': Letter.S,
  'T': Letter.T,
  'U': Letter.U,
  'V': Letter.V,
  'W': Letter.W,
  'X': Letter.X,
  'Y': Letter.Y,
  'Z': Letter.Z,
  '0': Letter.num0,
  '1': Letter.num1,
  '2': Letter.num2,
  '3': Letter.num3,
  '4': Letter.num4,
  '5': Letter.num5,
  '6': Letter.num6,
  '7': Letter.num7,
  '8': Letter.num8,
  '9': Letter.num9,
  '!': Letter.exclamation,
  '#': Letter.hash,
  '%': Letter.percent,
  '&': Letter.ampersand,
  '(': Letter.round_bracket_opem,
  ')': Letter.round_bracket_close,
  '[': Letter.square_bracket_open,
  ']': Letter.square_bracket_close,
  '{': Letter.curly_bracket_open,
  '}': Letter.curly_bracket_close,
  '+': Letter.plus,
  '=': Letter.equals_to,
  '<': Letter.less_than,
  '>': Letter.greater_than,
  '/': Letter.forward_slash,
  '\\': Letter.backward_slash,
  '.': Letter.full_stop,
  '-': Letter.dash,
  '?': Letter.question_mark,
  '\'': Letter.single_quote,
  '"': Letter.double_quote,
  ':': Letter.colon,
  ';': Letter.semi_colon,
  '@': Letter.at_the_rate,
  '_': Letter.underscore,
  '~': Letter.tilde,
  '\$': Letter.dollar,
  '*': Letter.asterik,
  '^': Letter.caret,
};
