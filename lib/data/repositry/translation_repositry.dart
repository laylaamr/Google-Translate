import 'package:googletranslate/data/api/translation_api.dart';

class TranslationRepository{
  late final TranslationApi translationApi;
  TranslationRepository(this.translationApi);
  Future<String?> translatedText(String text , String toLang , String fromLang) async{
    try {
      return await translationApi.translate(text, toLang, fromLang);
    } catch (e) {
      print('Repository error: $e');
      return null;
    }
}
}