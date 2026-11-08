import 'dart:ui';

// import '../../gen/assets.gen.dart';

enum Language {
  en(
    Locale('en'),
    'English',
    'Roboto',
  ),
  vi(
    Locale('vi'),
    'Tiếng Việt',
    'Be Vietnam Pro',
  ),
  ;

  const Language(this.value,  this.text, this.fontFamily);

  final Locale value;
  final String text;

  /// Google Fonts family used for this language's script.
  final String fontFamily;
}