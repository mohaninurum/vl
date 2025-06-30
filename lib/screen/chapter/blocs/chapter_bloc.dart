import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/screen/chapter/blocs/chapter_event.dart';

import '../../../repo/api_repository_lmp.dart';
import '../../auth/login_screen/blocs/login_bloc.dart';
import '../model/class_detail_model.dart';
import 'chapter_state.dart';

class ChapterListBloc extends Bloc<ChapterListEvent, ChapterListState> {
  ChapterListBloc() : super(InitailChapterList()) {
    on<LoadChapterList>((event, emit) async {
      try {
        print("load class");
        print("Class ID----------${event.id}");
        emit(IsLoadingChapterList());
        Map<String, dynamic> body = {'auth': BlocProvider.of<LoginBloc>(event.context).loginResponse?.user?.token.toString() ?? ''};
        final loginresponce = await ApiRepositoryImpl().getClassDetail(body: body, id: event.id);
        if (loginresponce["status"] == true) {
          ClassDetailResponse loginResponse = ClassDetailResponse.fromJson(loginresponce);
          emit(LoadedChapterList(classDetailResponse: loginResponse));
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(loginresponce["message"])));
          emit(FailChapterList());
        }
      } on TimeoutException catch (e) {
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
      } catch (e) {
        emit(FailChapterList());
        print("error :-$e");
        // emit(state.copyWith(isSubmitting: false, emailError: 'Something went wrong, try again.'));
      }
    });
  }
}
