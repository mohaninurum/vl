import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/screen/all_content/block/all_content_event.dart';

import '../model/all_content_model.dart';
import 'all_content_state.dart';

class ChapterContentBloc extends Bloc<ChapterContentEvent, ChapterContentState> {
  // final chapters = [
  //   ChapterContentModel(imageUrl: 'https://img.youtube.com/vi/fq4N0hgOWzU/0.jpg', title: '1. Motion', subtitle: 'Chapter: Motion', gradeLang: '9th English', bgColor: Colors.grey.shade200),
  //   ChapterContentModel(imageUrl: 'https://img.youtube.com/vi/fq4N0hgOWzU/1.jpg', title: '2. Motion along a straight line', subtitle: 'Chapter: Motion', gradeLang: '9th English', bgColor: Colors.grey.shade200),
  //   ChapterContentModel(imageUrl: 'https://img.youtube.com/vi/fq4N0hgOWzU/2.jpg', title: '3. Uniform and non uniform motion ', subtitle: 'Chapter: Motion', gradeLang: '9th English', bgColor: Colors.grey.shade300),
  //   ChapterContentModel(imageUrl: 'https://img.youtube.com/vi/fq4N0hgOWzU/3.jpg', title: '4. Basic terms use in motion', subtitle: 'Chapter: Motion', gradeLang: '9th English', bgColor: Colors.grey.shade300),
  // ];
  final chapters = [
    ChapterContentModel(imageUrl: 'https://img.youtube.com/vi/fq4N0hgOWzU/0.jpg', title: 'Motion', subtitle: 'Chapter: Motion', gradeLangEn: '9th English', gradeLangHi: '9th hindi', bgColor: Colors.grey.shade200),
    ChapterContentModel(imageUrl: 'https://img.youtube.com/vi/fq4N0hgOWzU/1.jpg', title: 'Motion along a straight line', subtitle: 'Chapter: Motion', gradeLangEn: '9th English', gradeLangHi: '9th hindi', bgColor: Colors.grey.shade200),
    ChapterContentModel(imageUrl: 'https://img.youtube.com/vi/fq4N0hgOWzU/2.jpg', title: 'Uniform and non uniform motion', subtitle: 'Chapter: Motion', gradeLangEn: '9th English', gradeLangHi: '9th hindi', bgColor: Colors.grey.shade200),
    ChapterContentModel(imageUrl: 'https://img.youtube.com/vi/fq4N0hgOWzU/3.jpg', title: '.Basic terms use in motion', subtitle: 'Chapter: Motion', gradeLangEn: '9th English', gradeLangHi: '9th hindi', bgColor: Colors.grey.shade200),
    ChapterContentModel(imageUrl: 'https://img.youtube.com/vi/fq4N0hgOWzU/0.jpg', title: 'Motion', subtitle: 'Chapter: Motion', gradeLangEn: '9th English', gradeLangHi: '9th hindi', bgColor: Colors.grey.shade200),
    // Add more...
  ];

  ChapterContentBloc() : super(ChapterContentState(chapters: [], isEnglishSelected: true)) {
    // on<LoadChaptersContent>((event, emit) {
    //   emit(state.copyWith(chapters: chapters));
    // });

    on<ChapterTapped>((event, emit) {
      emit(state.copyWith(selectedChapter: event.selected));
      debugPrint('Selected: ${event.selected.title}');
    });
    // on<ToggleLanguageEvent>((event, emit) {
    //   emit(state.copyWith(isEnglishSelected: !state.isEnglishSelected));
    // });
    on<SelectChapterEvent>((event, emit) {
      emit(state.copyWith(selectedChapter: event.chapter));
    });
    on<LoadChaptersContent>((event, emit) {
      emit(state.copyWith(chapters: chapters));
    });

    on<ToggleLanguageEvent>((event, emit) {
      emit(state.copyWith(isEnglishSelected: !state.isEnglishSelected));
    });
  }
}
