import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dars_5_3_getx/utils/words_list.dart';

part 'words_state.dart';
part 'words_event.dart';

class WordsBloc extends Bloc<WordsEvent, WordsState> {
  WordsBloc() : super(WordsInitialState()) {
    on<RoundStartEvent>(_makeEmptyList);
    on<MakeTryEvent>(_checkAnswer);
    on<CancelAnswerLetterEvent>(_cancelAnswerLetter);
    on<NextRoundEvent>(_next);
  }

  void _makeEmptyList(RoundStartEvent event, Emitter<WordsState> emit) {
    emit(WordsLoadingState());

    try {
      answer.clear();
      letters.clear();

      for (var i = 0; i < wordsList[curIndex].length; i++) {
        answer.add(" ");
      }
      letters = [...wordsList[curIndex]];
      for (var i = letters.length; i < 12; i++) {
        letters
            .add(String.fromCharCode(Random().nextInt(26) + 65).toLowerCase());
      }
      letters.shuffle();
      emit(WordsLoadedState(
          word: wordsList[curIndex], answer: answer, letters: letters));
    } catch (error) {
      emit(WordsErrorState(error: error.toString()));
    }
  }

  void _checkWord() {
    if (wordsList[curIndex].join() == answer.join()) {
      checkWin = true;
    } else {
      checkWin = false;
    }
  }

  void _checkAnswer(MakeTryEvent event, Emitter<WordsState> emit) {
    try {
      String letter = letters[event.index];
      if (answer.contains(" ")) {
        letters[event.index] = " ";
      }
      for (var i = 0; i < answer.length; i++) {
        if (answer[i] == " ") {
          answer[i] = letter;
          break;
        }
      }

      _checkWord();
      print(checkWin);
      emit(WordsLoadedState(
          word: wordsList[curIndex], answer: answer, letters: letters));
    } catch (e) {
      emit(WordsErrorState(error: e.toString()));
    }
  }

  void _cancelAnswerLetter(
      CancelAnswerLetterEvent event, Emitter<WordsState> emit) {
    try {
      letters[letters.indexOf(" ")] = answer[event.index];
      answer[event.index] = " ";
      emit(WordsLoadedState(
          word: wordsList[curIndex], answer: answer, letters: letters));
    } catch (e) {
      emit(WordsErrorState(error: e.toString()));
    }
  }

  void _next(NextRoundEvent event, Emitter<WordsState> emit) {
    try {
      if (curIndex != wordsList.length) {
        curIndex += 1;
      } else {
        curIndex = 0;
      }
      answer.clear();
      letters.clear();
      checkWin = false;
      _makeEmptyList(
          RoundStartEvent(), emit); // Directly call _makeEmptyList method
    } catch (e) {
      emit(WordsErrorState(error: e.toString()));
    }
  }
}
