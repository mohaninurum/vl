import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/notes_model.dart';
import 'notes_event.dart';
import 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesState(allNotes: [], selectedClass: '9th', selectedSubject: 'Science', filteredNotes: [])) {
    on<LoadNotes>(_onLoadNotes);
    on<SelectClass>(_onSelectClass);
    on<SelectSubject>(_onSelectSubject);
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

    emit(state.copyWith(allNotes: notes, filteredNotes: _filterNotes(notes, state.selectedClass, state.selectedSubject)));
  }

  void _onSelectClass(SelectClass event, Emitter<NotesState> emit) {
    emit(state.copyWith(selectedClass: event.className, filteredNotes: _filterNotes(state.allNotes, event.className, state.selectedSubject)));
  }

  void _onSelectSubject(SelectSubject event, Emitter<NotesState> emit) {
    emit(state.copyWith(selectedSubject: event.subject, filteredNotes: _filterNotes(state.allNotes, state.selectedClass, event.subject)));
  }

  List<NoteModel> _filterNotes(List<NoteModel> notes, String className, String subject) {
    return notes.where((note) => note.className == className && note.subject == subject).toList();
  }
}
