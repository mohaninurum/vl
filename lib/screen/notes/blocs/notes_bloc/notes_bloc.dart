import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repo/api_repository_lmp.dart';
import '../../../classes/models/class_list_model.dart';
import '../../models/subject_model.dart';
import 'notes_event.dart';
import 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  List<String> subjectsbloc = ['Science', 'Biology'];
  // List<String> classes = ['9th', '10th'];
  ClassListResponse? Response;
  ClassListResponse? classListResponse;
  SubjectResponse? subjectList;
  NotesBloc() : super(IsinitialNotesClass()) {
    on<GetClasses>(_onGetClasses);
  }

  Future<void> _onGetClasses(GetClasses event, Emitter<NotesState> emit) async {
    try {
      print("Loading classes...");
      emit(IsLoadigNotesClass());

      Map<String, dynamic> body = {'auth': event.token};
      final Response = await ApiRepositoryImpl().getClassListByCategory(body: body);

      if (Response["status"] == true) {
        classListResponse = ClassListResponse.fromJson(Response);

        // This is now a list of SubjectData (not just subjectName strings)
        List<String>? cModels = classListResponse?.data.map((e) => "${e.className}").toList();
        emit(LoadedNotesClass(Classbloc: cModels));
        //  emit(state.copyWith(isLoadingSubject: false, classes: [], subject: subjectModels));

        //print("Subjects loaded: ${state.subject}");
      } else {
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(Response["message"] ?? "Failed to load subjects.")));
        // emit(state.copyWith(isLoadingSubject: false, classes: []));
      }
    } on TimeoutException {
      //emit(state.copyWith(isLoadingSubject: false, classes: []));
      ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
    } catch (e) {
      print("Error loading subjects: $e");
      //  emit(state.copyWith(isLoadingSubject: false, classes: []));
    }
  }
}
