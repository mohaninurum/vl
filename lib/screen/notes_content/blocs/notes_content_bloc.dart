import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repo/api_repository_lmp.dart';
import '../models/notes_content_model.dart';
import 'notes_content_event.dart';
import 'notes_content_state.dart';

class NotesContentBloc extends Bloc<NotesContentEvent, NotesContentState> {
  NotesContentBloc() : super(InitailNotesContent()) {
    on<LoadNotesContent>((event, emit) async {
      try {
        print("load class");
        emit(IsLoadingNotesContent());
        Map<String, dynamic> body = {'auth': event.token};
        final loginresponce = await ApiRepositoryImpl().getNotesContentPdf(body: body, id: "1");
        if (loginresponce["status"] == true) {
          NotesPdfResponse loginResponse = NotesPdfResponse.fromJson(loginresponce);
          emit(LoadedNotesContent(notesPdfResponse: loginResponse));
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(loginresponce["message"])));
          emit(FailNotesContent());
        }
      } on TimeoutException catch (e) {
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
      } catch (e) {
        emit(FailNotesContent());
        print("error :-$e");
        // emit(state.copyWith(isSubmitting: false, emailError: 'Something went wrong, try again.'));
      }
    });
  }
}
