abstract class TranslaionState{}
class TranslationInitial extends TranslaionState{}

class TranslationLoading extends TranslaionState {}
class TranslationLoaded extends TranslaionState{
  final String? translation;


  TranslationLoaded({required this.translation});

}

class TranslationError extends TranslaionState {
  final String? message;

  TranslationError(this.message);
}