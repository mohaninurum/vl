// --- BLoC ---
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/screen/quiz/bloc/quiz_event.dart' hide Preview;
import 'package:visual_learning/screen/quiz/bloc/quiz_state.dart';

import '../../../repo/api_repository_lmp.dart';
import '../models/question_model.dart';
import '../models/quiz_responce.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  List<int> updatedSelected = [];
  QuizResponse? Response;
  QuizBloc() : super(QuizState.initial()) {
    on<PreviewQuiz>((event, emit) {
      List<QuestionModel> questions = [];
      for (var element in Response!.data) {
        questions.add(QuestionModel(question: element.question, options: [element.optionA, element.optionB, element.optionC, element.optionD], correctIndex: element.rightAnswer - 1, explanation: element.explanation ?? ''));
      }

      emit(state.copyWith(isLoading: true, questions: questions, selectedAnswers: updatedSelected));
    });
    on<SelectAnswer>((event, emit) {
      // emit(state.copyWith(isSelectAnswer: true, selectedIndex: event.index, selectedAnswers: []));
      // final updatedSelected = List<int>.from(state.selectedAnswers);

      // If current index already has a recorded answer, update it
      if (updatedSelected.length > state.currentIndex) {
        updatedSelected[state.currentIndex] = event.index;
      } else {
        // Else, add new entry for this question
        updatedSelected.add(event.index);
      }
      emit(
        state.copyWith(
          isSelectAnswer: true,
          selectedIndex: event.index,
          selectedAnswers: updatedSelected, // ✅ Save answer for review
        ),
      );
    });

    on<IsLoadingQuiz>((event, emit) async {
      emit(state.copyWith(questions: [], currentIndex: 0, selectedIndex: -1, showResult: false, showExplanation: false, isSelectAnswer: false, isLoading: false, selectedAnswers: []));
      updatedSelected.clear();
      try {
        Map<String, dynamic> body = {'auth': event.token};
        final loginresponce = await ApiRepositoryImpl().getQuizContent(body: body, id: event.id);
        if (loginresponce["status"] == true) {
          Response = QuizResponse.fromJson(loginresponce);
          List<QuestionModel> questions = [];
          for (var element in Response!.data) {
            questions.add(QuestionModel(question: element.question, options: [element.optionA, element.optionB, element.optionC, element.optionD], correctIndex: element.rightAnswer - 1, explanation: element.explanation ?? ''));
          }

          emit(state.copyWith(isLoading: true, questions: questions, selectedAnswers: []));
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(loginresponce["message"])));
          emit(state.copyWith(isLoading: true, selectedAnswers: []));
        }
      } on TimeoutException catch (e) {
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
        emit(state.copyWith(isLoading: true, selectedAnswers: []));
      } catch (e) {
        emit(state.copyWith(isLoading: true, selectedAnswers: []));
        print("error :-$e");
        // emit(state.copyWith(isSubmitting: false, emailError: 'Something went wrong, try again.'));
      }
    });
    on<SuccessQuiz>((event, emit) {
      emit(state.copyWith(isLoading: true, selectedAnswers: []));
    });
    on<CheckAnswer>((event, emit) {
      emit(state.copyWith(showResult: true, isSelectAnswer: false, selectedAnswers: []));
    });

    on<ShowExplanationAnswer>((event, emit) {
      emit(state.copyWith(showExplanation: !event.showExplanation, selectedAnswers: []));
    });
    on<ResetAnswer>((event, emit) {
      emit(state.copyWith(showResult: false, selectedIndex: -1, isSelectAnswer: false, selectedAnswers: []));
    });

    on<NextQuestion>((event, emit) {
      if (!state.isLast) {
        emit(state.copyWith(currentIndex: state.currentIndex + 1, selectedIndex: -1, showExplanation: false, isSelectAnswer: false, selectedAnswers: []));
      }
    });

    on<PreviousQuestion>((event, emit) {
      if (!state.isFirst) {
        emit(state.copyWith(currentIndex: state.currentIndex - 1, selectedIndex: -1, showResult: false, isSelectAnswer: false, showExplanation: false, selectedAnswers: []));
      }
    });
  }
}
