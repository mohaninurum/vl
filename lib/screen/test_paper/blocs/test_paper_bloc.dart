import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/test_paper_model.dart';
import 'test_paper_event.dart';
import 'test_paper_state.dart';

class TestPaperBloc extends Bloc<TestPaperEvent, TestPaperState> {
  TestPaperBloc() : super(TestPaperState(allTestPaper: [], selectedClass: '9th', selectedSubject: 'Science', filteredTestPaper: [])) {
    on<LoadTestPaper>(_onLoadNotes);
    on<SelectClass>(_onSelectClass);
    on<SelectSubject>(_onSelectSubject);
  }

  Future<void> _onLoadNotes(LoadTestPaper event, Emitter<TestPaperState> emit) async {
    emit(TestPaperLoading());
    await Future.delayed(Duration(seconds: 1));
    final notes = [
      TestPaperModel(title: 'Matter In Our Surroundings', className: '9th', subject: 'Science'), //
      TestPaperModel(title: 'The Fundamental Unit Of Life', className: '9th', subject: 'Biology'),
    ];

    emit(state.copyWith(allNotes: notes, filteredNotes: _filterTestPaper(notes, state.selectedClass, state.selectedSubject)));
  }

  void _onSelectClass(SelectClass event, Emitter<TestPaperState> emit) {
    emit(state.copyWith(selectedClass: event.className, filteredNotes: _filterTestPaper(state.allTestPaper, event.className, state.selectedSubject)));
  }

  void _onSelectSubject(SelectSubject event, Emitter<TestPaperState> emit) {
    emit(state.copyWith(selectedSubject: event.subject, filteredNotes: _filterTestPaper(state.allTestPaper, state.selectedClass, event.subject)));
  }

  List<TestPaperModel> _filterTestPaper(List<TestPaperModel> notes, String className, String subject) {
    return notes.where((note) => note.className == className && note.subject == subject).toList();
  }
}
