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
  NotesBloc()
    : super(
        IsinitialNotesClass(),
        // NotesState(allNotes: [], selectedClass: '9th', selectedSubject: 'Science', filteredNotes: [], classes: [], isLoadingSubject: true, isLoading: true)
      ) {
    // on<LoadNotes>(_onLoadNotes);
    // on<SelectClass>(_onSelectClass);
    // on<GetSubject>(_onGetSubject);
    on<GetClasses>(_onGetClasses);
  }

  // Future<void> _onLoadNotes(LoadNotes event, Emitter<NotesState> emit) async {
  //   emit(NotesLoading());
  //
  //   await Future.delayed(Duration(seconds: 1));
  //   final notes = [
  //     NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
  //     NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
  //     NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
  //     NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
  //     NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
  //     NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
  //     NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
  //     NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
  //     NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
  //     NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
  //     NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
  //     NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
  //     NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
  //     NoteModel(title: 'Is Matter around us pure', className: '9th', subject: 'Science'),
  //     NoteModel(title: 'Matter In Our Surroundings', className: '10th', subject: 'Science'),
  //     NoteModel(title: 'Matter In Our Surroundings', className: '10th', subject: 'Science'),
  //     NoteModel(title: 'Matter In Our Surroundings', className: '10th', subject: 'Science'),
  //     NoteModel(title: 'Matter In Our Surroundings', className: '10th', subject: 'Science'),
  //     NoteModel(title: 'Matter In Our Surroundings', className: '10th', subject: 'Science'),
  //     NoteModel(title: 'Matter In Our Surroundings', className: '10th', subject: 'Science'),
  //     NoteModel(title: 'Matter In Our Surroundings', className: '10th', subject: 'Science'),
  //     NoteModel(title: 'Matter In Our Surroundings', className: '10th', subject: 'Science'),
  //     NoteModel(title: 'Matter In Our Surroundings', className: '10th', subject: 'Science'),
  //     NoteModel(title: 'Matter In Our Surroundings', className: '10th', subject: 'Science'),
  //     NoteModel(title: 'Matter In Our Surroundings', className: '10th', subject: 'Science'),
  //     NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
  //     NoteModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'),
  //     NoteModel(title: 'Is Matter around us pure', className: '9th', subject: 'Science'),
  //     NoteModel(title: 'Atoms And Molecules', className: '9th', subject: 'Science'),
  //     NoteModel(title: 'Structure Of The Atom', className: '9th', subject: 'Science'),
  //     NoteModel(title: 'The Fundamental Unit Of Life', className: '9th', subject: 'Biology'),
  //     NoteModel(title: 'Tissues', className: '9th', subject: 'Biology'),
  //   ];
  //
  //   emit(state.copyWith(allNotes: notes, filteredNotes: _filterNotes(notes, state.selectedClass, state.selectedSubject), classes: [], isLoadingSubject: false));
  // }
  //
  // void _onSelectClass(SelectClass event, Emitter<NotesState> emit) {
  //   emit(state.copyWith(selectedClass: event.className, filteredNotes: _filterNotes(state.allNotes, event.className, state.selectedSubject), classes: [], isLoadingSubject: false));
  // }
  //
  // void _onSelectSubject(SelectSubject event, Emitter<NotesState> emit) {
  //   emit(state.copyWith(selectedSubject: event.subject, filteredNotes: _filterNotes(state.allNotes, state.selectedClass, event.subject), classes: [], isLoadingSubject: false));
  // }
  //
  // Future<void> _onGetSubject(GetSubject event, Emitter<NotesState> emit) async {
  //   try {
  //     print("Loading subjects...");
  //     // emit(state.copyWith(isLoadingSubject: true, classes: []));
  //
  //     Map<String, dynamic> body = {'auth': event.token};
  //     final loginResponse = await ApiRepositoryImpl().getSubject(body: body, id: event.id);
  //
  //     if (loginResponse["status"] == true) {
  //       SubjectResponse subjectList = SubjectResponse.fromJson(loginResponse);
  //       // This is now a list of SubjectData (not just subjectName strings)
  //       List<String> subjectModels = subjectList.data.map((e) => e.subjectName).toList();
  //       // emit(LoadedNotes(subjectsbloc: subjectModels));
  //       //  emit(state.copyWith(isLoadingSubject: false, classes: [], subject: subjectModels));
  //
  //       //print("Subjects loaded: ${state.subject}");
  //     } else {
  //       ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(loginResponse["message"] ?? "Failed to load subjects.")));
  //       // emit(state.copyWith(isLoadingSubject: false, classes: []));
  //     }
  //   } on TimeoutException {
  //     //emit(state.copyWith(isLoadingSubject: false, classes: []));
  //     ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
  //   } catch (e) {
  //     print("Error loading subjects: $e");
  //     //  emit(state.copyWith(isLoadingSubject: false, classes: []));
  //   }
  // }

  // Future<void> _onGetClasses(GetClasses event, Emitter<NotesState> emit) async {
  //   print("bolc");
  //   print(state.classes);
  //   try {
  //     print("load classes");
  //     Map<String, dynamic> body = {'auth': event.token};
  //     final responce = await ApiRepositoryImpl().getClassListByCategory(body: body);
  //     if (responce["status"] == true) {
  //       Response = ClassListResponse.fromJson(responce);
  //       // emit(LoadedClassList(classListResponse: Response));
  //       List<String> classes = [];
  //       Response?.data.forEach((element) => classes.add(element.className));
  //       emit(state.copyWith(isLoading: false, isLoadingSubject: false, classes: classes));
  //     } else {
  //       ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(responce["message"])));
  //       emit(state.copyWith(isLoading: true, isLoadingSubject: false, classes: []));
  //     }
  //   } on TimeoutException catch (e) {
  //     emit(state.copyWith(isLoading: true, isLoadingSubject: false, classes: []));
  //     ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
  //   } catch (e) {
  //     emit(state.copyWith(isLoading: true, isLoadingSubject: false, classes: []));
  //     print("error :-$e");
  //     // emit(state.copyWith(isSubmitting: false, emailError: 'Something went wrong, try again.'));
  //   }
  // }

  // Future<void> _onGetSubject(GetSubject event, Emitter<NotesState> emit) async {
  //   try {
  //     print("Loading subjects...");
  //     // emit(state.copyWith(isLoadingSubject: true, classes: []));
  //     // var indexget = event.id.indexOf('t');
  //     // var getclass = event.id.substring(0, indexget);
  //     // print("get:- $getclass");
  //     // var classId = classListResponse?.data.firstWhere((element) => element.className == getclass).classId;
  //     // print("get class id :-$classId");
  //     Map<String, dynamic> body = {'auth': event.token};
  //     final Response = await ApiRepositoryImpl().getSubject(body: body, id: event.id);
  //     if (Response["status"] == true) {
  //       subjectList = SubjectResponse.fromJson(Response);
  //
  //       // This is now a list of SubjectData (not just subjectName strings)
  //       List<String>? subjectModels = subjectList?.data.map((e) => e.subjectName).toList();
  //       emit(LoadedSubjectNotes(subjectsbloc: subjectModels));
  //       //  emit(state.copyWith(isLoadingSubject: false, classes: [], subject: subjectModels));
  //
  //       //print("Subjects loaded: ${state.subject}");
  //     } else {
  //       ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(Response["message"] ?? "Failed to load subjects.")));
  //       // emit(state.copyWith(isLoadingSubject: false, classes: []));
  //     }
  //   } on TimeoutException {
  //     //emit(state.copyWith(isLoadingSubject: false, classes: []));
  //     ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
  //   } catch (e) {
  //     print("Error loading subjects: $e");
  //     //  emit(state.copyWith(isLoadingSubject: false, classes: []));
  //   }
  // }

  Future<void> _onGetClasses(GetClasses event, Emitter<NotesState> emit) async {
    try {
      print("Loading classes...");
      emit(IsLoadigNotesClass());

      Map<String, dynamic> body = {'auth': event.token};
      final Response = await ApiRepositoryImpl().getClassListByCategory(body: body);

      if (Response["status"] == true) {
        classListResponse = ClassListResponse.fromJson(Response);

        // This is now a list of SubjectData (not just subjectName strings)
        List<String>? cModels = classListResponse?.data.map((e) => "${e.className}th").toList();
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
