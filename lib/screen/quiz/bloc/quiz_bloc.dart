// --- BLoC ---
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/screen/quiz/bloc/quiz_event.dart';
import 'package:visual_learning/screen/quiz/bloc/quiz_state.dart';

import '../../../repo/api_repository_lmp.dart';
import '../models/question_model.dart';
import '../models/quiz_responce.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizState.initial()) {
    on<SelectAnswer>((event, emit) {
      emit(state.copyWith(isSelectAnswer: true, selectedIndex: event.index));
    });

    on<IsLoadingQuiz>((event, emit) async {

      emit(state.copyWith(questions: [], currentIndex: 0, selectedIndex: -1, showResult: false, showExplanation: false, isSelectAnswer: false, isLoading: false));

      try {
        Map<String, dynamic> body = {'auth': event.token};
        final loginresponce = await ApiRepositoryImpl().getQuizContent(body: body, id: event.id);
        if (loginresponce["status"] == true) {
          QuizResponse Response = QuizResponse.fromJson(loginresponce);
          List<QuestionModel> questions = [];
          for (var element in Response.data) {
            questions.add(QuestionModel(question: element.questionText, options: [element.option1, element.option2, element.option3, element.option4], correctIndex: element.correctOption - 1, explanation: element.explanation ?? ''));
          }
          emit(state.copyWith(isLoading: true, questions: questions));
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(loginresponce["message"])));
          emit(state.copyWith(isLoading: true));
        }
      } on TimeoutException catch (e) {
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
        emit(state.copyWith(isLoading: true));
      } catch (e) {
        emit(state.copyWith(isLoading: true));
        print("error :-$e");
        // emit(state.copyWith(isSubmitting: false, emailError: 'Something went wrong, try again.'));
      }
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
