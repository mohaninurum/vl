import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repo/api_repository_lmp.dart';
import '../../../chapter/model/class_detail_model.dart';
import 'get_subject_event.dart';
import 'get_subject_state.dart';

class GetSubjectBloc extends Bloc<GetSubjectEvent, NotesSubjectState> {
  ClassDetailResponse? subjectList;
  GetSubjectBloc() : super(IsinitialNotesSubject()) {
    on<GetSubject>(_onGetSubject);
  }

  Future<void> _onGetSubject(GetSubject event, Emitter<NotesSubjectState> emit) async {
    try {
      Map<String, dynamic> body = {'auth': event.token};
      final Response = await ApiRepositoryImpl().getSubject(body: body, id: event.id);
      if (Response["status"] == true) {
        subjectList = ClassDetailResponse.fromJson(Response);
        List<String>? subjectModels = subjectList?.data.subjects.map((e) => e.subjectName).toList();
        emit(LoadedNotesSubject(subjectsbloc: subjectModels));
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
