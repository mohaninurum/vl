import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/screen/chapter/blocs/subjecttab_event.dart';
import 'package:visual_learning/screen/chapter/blocs/subjecttab_state.dart';

import '../model/chapter_list_model.dart';

class SubjectTabBloc extends Bloc<SubjectTabEvent, SubjectTabState> {
  SubjectTabBloc() : super(SubjectTabState(chapters: _getChaptersForTab(0), selectedTab: 0)) {
    on<SubjectChanged>((event, emit) {
      emit(SubjectTabState(chapters: _getChaptersForTab(event.tabIndex), selectedTab: event.tabIndex));
    });
  }

  static List<ChapterListModel> _getChaptersForTab(int index) {
    switch (index) {
      case 0: // Physics
        return [ChapterListModel("Motions"), ChapterListModel("Motions"), ChapterListModel("Motions"), ChapterListModel("Motions"), ChapterListModel("Motions"), ChapterListModel("Motions"), ChapterListModel("Motions"), ChapterListModel("Motions"), ChapterListModel("Motions"), ChapterListModel("Motions"), ChapterListModel("Motions"), ChapterListModel("Motions"), ChapterListModel("Force And Laws Of Motion"), ChapterListModel("Gravitation"), ChapterListModel("Work And Energy"), ChapterListModel("Sound")];
      case 1: // Chemistry
        return [ChapterListModel("Atoms and Molecules"), ChapterListModel("Atoms and Molecules"), ChapterListModel("Atoms and Molecules"), ChapterListModel("Atoms and Molecules"), ChapterListModel("Atoms and Molecules"), ChapterListModel("Atoms and Molecules"), ChapterListModel("Atoms and Molecules"), ChapterListModel("Atoms and Molecules"), ChapterListModel("Structure of Atom"), ChapterListModel("Chemical Reactions")];
      case 2: // Biology
        return [ChapterListModel("The Fundamental Unit of Life"), ChapterListModel("Tissues"), ChapterListModel("Diversity in Living Organisms")];
      default:
        return [];
    }
  }
}
