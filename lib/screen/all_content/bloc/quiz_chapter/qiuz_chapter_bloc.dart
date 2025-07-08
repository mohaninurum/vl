// --- BLoC ---
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/screen/all_content/bloc/quiz_chapter/qiuz_chapter_event.dart';
import 'package:visual_learning/screen/all_content/bloc/quiz_chapter/qiuz_chapter_state.dart';

import '../../../../repo/api_repository_lmp.dart';
import '../../model/quiz_chapter_model.dart';

class QiuzChapterBloc extends Bloc<LoadedChapterQuiz, QiuzChapterState> {
  QuizListResponse? Response;
  QiuzChapterBloc() : super(initialQuizState()) {
    on<LoadedChapterQuiz>((event, emit) async {
      emit(LoadingQuizState());
      try {
        Map<String, dynamic> body = {'auth': event.token};
        final responce = await ApiRepositoryImpl().getQuizContent(body: body, id: event.id);
        if (responce["status"] == true) {
          Response = QuizListResponse.fromJson(responce);
          emit(LoadedQuizState(questions: Response));
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(responce["message"])));
          emit(FailQuizState());
        }
      } on TimeoutException catch (e) {
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
        emit(FailQuizState());
      } catch (e) {
        emit(FailQuizState());
        print("error :-$e");
        // emit(state.copyWith(isSubmitting: false, emailError: 'Something went wrong, try again.'));
      }
    });
  }
}
