import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repo/api_repository_lmp.dart';
import '../models/notes_model.dart';
import '../models/subject_model.dart';
import 'notes_event.dart';
import 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  List<String> subjectsbloc = ['Science', 'Biology'];
  NotesBloc() : super(NotesState(allNotes: [], selectedClass: '9th', selectedSubject: 'Science', filteredNotes: [], classes: [], isLoadingSubject: true)) {
    on<LoadNotes>(_onLoadNotes);
    on<SelectClass>(_onSelectClass);
    on<SelectSubject>(_onSelectSubject);
    on<GetSubject>(_onGetSubject);
  }

  Future<void> _onLoadNotes(LoadNotes event, Emitter<NotesState> emit) async {
    emit(NotesLoading());

    await Future.delayed(Duration(seconds: 1));
    final notes = [
      NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
      NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
      NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
      NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
      NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
      NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
      NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
      NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
      NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
      NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
      NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
      NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
      NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
      NoteModel(title: 'Is Matter around us pure', className: '9th', subject: 'Science'),
      NoteModel(title: 'Matter In Our Surroundings', className: '10th', subject: 'Science'),
      NoteModel(title: 'Matter In Our Surroundings', className: '10th', subject: 'Science'),
      NoteModel(title: 'Matter In Our Surroundings', className: '10th', subject: 'Science'),
      NoteModel(title: 'Matter In Our Surroundings', className: '10th', subject: 'Science'),
      NoteModel(title: 'Matter In Our Surroundings', className: '10th', subject: 'Science'),
      NoteModel(title: 'Matter In Our Surroundings', className: '10th', subject: 'Science'),
      NoteModel(title: 'Matter In Our Surroundings', className: '10th', subject: 'Science'),
      NoteModel(title: 'Matter In Our Surroundings', className: '10th', subject: 'Science'),
      NoteModel(title: 'Matter In Our Surroundings', className: '10th', subject: 'Science'),
      NoteModel(title: 'Matter In Our Surroundings', className: '10th', subject: 'Science'),
      NoteModel(title: 'Matter In Our Surroundings', className: '10th', subject: 'Science'),
      NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
      NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
      NoteModel(title: 'Is Matter around us pure', className: '9th', subject: 'Science'),
      NoteModel(title: 'Atoms And Molecules', className: '9th', subject: 'Science'),
      NoteModel(title: 'Structure Of The Atom', className: '9th', subject: 'Science'),
      NoteModel(title: 'The Fundamental Unit Of Life', className: '9th', subject: 'Biology'),
      NoteModel(title: 'Tissues', className: '9th', subject: 'Biology'),
    ];

    emit(state.copyWith(allNotes: notes, filteredNotes: _filterNotes(notes, state.selectedClass, state.selectedSubject), classes: [], isLoadingSubject: false));
  }

  void _onSelectClass(SelectClass event, Emitter<NotesState> emit) {
    emit(state.copyWith(selectedClass: event.className, filteredNotes: _filterNotes(state.allNotes, event.className, state.selectedSubject), classes: [], isLoadingSubject: false));
  }

  void _onSelectSubject(SelectSubject event, Emitter<NotesState> emit) {
    emit(state.copyWith(selectedSubject: event.subject, filteredNotes: _filterNotes(state.allNotes, state.selectedClass, event.subject), classes: [], isLoadingSubject: false));
  }

  Future<void> _onGetSubject(GetSubject event, Emitter<NotesState> emit) async {
    try {
      print("Loading subjects...");
      // emit(state.copyWith(isLoadingSubject: true, classes: []));

      Map<String, dynamic> body = {'auth': event.token};
      final loginResponse = await ApiRepositoryImpl().getSubject(body: body, id: event.id);

      if (loginResponse["status"] == true) {
        SubjectResponse subjectList = SubjectResponse.fromJson(loginResponse);
        // This is now a list of SubjectData (not just subjectName strings)
        List<String> subjectModels = subjectList.data.map((e) => e.subjectName).toList();
        // emit(LoadedNotes(subjectsbloc: subjectModels));
        //  emit(state.copyWith(isLoadingSubject: false, classes: [], subject: subjectModels));

        //print("Subjects loaded: ${state.subject}");
      } else {
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(loginResponse["message"] ?? "Failed to load subjects.")));
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

  // Future<void> _onGetSubject(GetSubject event, Emitter<NotesState> emit) async {
  //   try {
  //     print("load class");
  //     // emit(IsLoadingClassList());
  //     emit(state.copyWith(isLoadingSubject: true, classes: [], subject: []));
  //
  //     Map<String, dynamic> body = {'auth': event.token};
  //     final loginresponce = await ApiRepositoryImpl().getSubject(body: body, id: event.id);
  //     if (loginresponce["status"] == true) {
  //       SubjectResponse subjectList = SubjectResponse.fromJson(loginresponce);
  //
  //       subjectList.data.forEach((element) => {subject.add(element.subjectName)});
  //       print(subject);
  //       emit(state.copyWith(isLoadingSubject: false, classes: [], subject: subject));
  //       print("check list::-${state.subject}");
  //     } else {
  //       ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(loginresponce["message"])));
  //       emit(state.copyWith(isLoadingSubject: false, classes: []));
  //     }
  //   } on TimeoutException catch (e) {
  //     emit(state.copyWith(isLoadingSubject: false, classes: []));
  //     ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
  //   } catch (e) {
  //     print("error :-$e");
  //     emit(state.copyWith(isLoadingSubject: false, classes: []));
  //     // emit(state.copyWith(isSubmitting: false, emailError: 'Something went wrong, try again.'));
  //   }
  // }

  List<NoteModel> _filterNotes(List<NoteModel> notes, String className, String subject) {
    return notes.where((note) => note.className == className && note.subject == subject).toList();
  }
}
