import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/screen/test_content/blocs/test_paper_content_event.dart';
import 'package:visual_learning/screen/test_content/blocs/test_paper_content_state.dart';

import '../../../repo/api_repository_lmp.dart';
import '../models/test_papar_model.dart';

class TestPaperContentBloc extends Bloc<TestPaperContentEvent, TestPaperContentState> {
  TestPaperContentBloc() : super(InitailTestPaperContent()) {
    on<LoadTestPaperContent>((event, emit) async {
      try {
        print("load class");
        emit(IsLoadingTestPaperContent());
        Map<String, dynamic> body = {'auth': event.token};
        final loginresponce = await ApiRepositoryImpl().getTestPaperContentPdf(body: body, id: event.id);
        if (loginresponce["status"] == true) {
          TestPaperResponse Response = TestPaperResponse.fromJson(loginresponce);
          emit(LoadedTestPaperContent(testPaperResponse: Response));
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(loginresponce["message"])));
          emit(FailTestPaperContent());
        }
      } on TimeoutException catch (e) {
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
      } catch (e) {
        emit(FailTestPaperContent());
        print("error :-$e");
        // emit(state.copyWith(isSubmitting: false, emailError: 'Something went wrong, try again.'));
      }
    });
  }
}
