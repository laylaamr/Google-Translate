import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googletranslate/buisness_logic_layer/translation_state.dart';
import 'package:googletranslate/data/repositry/translation_repositry.dart';

class TranslationCubit extends Cubit<TranslaionState>{
final TranslationRepository translationRepository;


  TranslationCubit(this.translationRepository): super(TranslationInitial());

  Future<void> fetchTranslatedText(
      String text , String toLang , String fromLang
      ) async{
    try {
      emit(TranslationLoading());
      final translationText = await translationRepository.translatedText(
          text, fromLang, toLang);

      if (translationText != null) {
        emit(TranslationLoaded(translation: translationText));
      } else {
        emit(TranslationError(
            'Translation failed: Unable to retrieve translation'));
      }
    } catch (e) {
      print('Error during translation: $e');
      emit(TranslationError('Error when translating text: ${e.toString()}'));
    }
  }
}