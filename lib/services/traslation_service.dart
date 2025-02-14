import 'package:translator/translator.dart';

class TranslationService {
  final GoogleTranslator _translator = GoogleTranslator();

  Future<String> translate(String text, {String from = 'es', String to = 'en'}) async {
    if (text.trim().isEmpty) {
      throw Exception('El texto a traducir está vacío');
    }
    final translation = await _translator.translate(text, from: from, to: to);
    return translation.text;
  }
}
