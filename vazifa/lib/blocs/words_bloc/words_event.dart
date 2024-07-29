part of "words_bloc.dart";

sealed class WordsEvent {}

class RoundStartEvent extends WordsEvent {}

class MakeTryEvent extends WordsEvent {
  final int index;

  MakeTryEvent({required this.index});
}

class CancelAnswerLetterEvent extends WordsEvent {
  final int index;

  CancelAnswerLetterEvent({required this.index});
}

class NextRoundEvent extends WordsEvent {}
