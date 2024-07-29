part of "words_bloc.dart";

sealed class WordsState {}

class WordsInitialState extends WordsState {}

class WordsLoadingState extends WordsState {}

class WordsLoadedState extends WordsState {
  final List<String> word;
  final List<String> answer;
  final List<String> letters;

  WordsLoadedState({required this.word, required this.answer, required this.letters});
}

class WordsErrorState extends WordsState {
  final String error;

  WordsErrorState({required this.error});
}

