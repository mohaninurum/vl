// --- BLoC ---
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/screen/quiz/bloc/quiz_event.dart';
import 'package:visual_learning/screen/quiz/bloc/quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizState.initial()) {
    on<SelectAnswer>((event, emit) {
      emit(state.copyWith(isSelectAnswer: true, selectedIndex: event.index));
    });

    on<IsLoadingQuiz>((event, emit) async {
      print("isloading");
      await Future.delayed(Duration(seconds: 3));
      print("isloading 3 second complete");
      emit(state.copyWith(isLoading: true));
    });
    on<SuccessQuiz>((event, emit) {
      emit(state.copyWith(isLoading: true));
    });
    on<CheckAnswer>((event, emit) {
      emit(state.copyWith(showResult: true, isSelectAnswer: false));
    });

    on<ShowExplanationAnswer>((event, emit) {
      emit(state.copyWith(showExplanation: !event.showExplanation));
    });
    on<ResetAnswer>((event, emit) {
      emit(state.copyWith(showResult: false, selectedIndex: -1, isSelectAnswer: false));
    });

    on<NextQuestion>((event, emit) {
      if (!state.isLast) {
        emit(state.copyWith(currentIndex: state.currentIndex + 1, selectedIndex: -1, showExplanation: false, isSelectAnswer: false));
      }
    });

    on<PreviousQuestion>((event, emit) {
      if (!state.isFirst) {
        emit(state.copyWith(currentIndex: state.currentIndex - 1, selectedIndex: -1, showResult: false, isSelectAnswer: false, showExplanation: false));
      }
    });
  }
}
