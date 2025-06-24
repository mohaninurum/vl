import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/screen/all_content/block/all_content_event.dart';

import '../../../repo/api_repository_lmp.dart';
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
    ChapterContentModel(imageUrl: 'https://img.youtube.com/vi/fq4N0hgOWzU/0.jpg', title: 'Motion', subtitle: 'Chapter: Motion', gradeLangEn: '9th English', gradeLangHi: '9th hindi', bgColor: Colors.grey.shade200, VideoUrl: ''),
    ChapterContentModel(imageUrl: 'https://img.youtube.com/vi/fq4N0hgOWzU/1.jpg', title: 'Motion along a straight line', subtitle: 'Chapter: Motion', gradeLangEn: '9th English', gradeLangHi: '9th hindi', bgColor: Colors.grey.shade200, VideoUrl: ''),
    ChapterContentModel(imageUrl: 'https://img.youtube.com/vi/fq4N0hgOWzU/2.jpg', title: 'Uniform and non uniform motion', subtitle: 'Chapter: Motion', gradeLangEn: '9th English', gradeLangHi: '9th hindi', bgColor: Colors.grey.shade200, VideoUrl: ''),
    ChapterContentModel(imageUrl: 'https://img.youtube.com/vi/fq4N0hgOWzU/3.jpg', title: '.Basic terms use in motion', subtitle: 'Chapter: Motion', gradeLangEn: '9th English', gradeLangHi: '9th hindi', bgColor: Colors.grey.shade200, VideoUrl: ''),
    ChapterContentModel(imageUrl: 'https://img.youtube.com/vi/fq4N0hgOWzU/0.jpg', title: 'Motion', subtitle: 'Chapter: Motion', gradeLangEn: '9th English', gradeLangHi: '9th hindi', bgColor: Colors.grey.shade200, VideoUrl: ''),
    // Add more...
  ];

  ChapterContentBloc() : super(ChapterContentState(chapters: [], isEnglishSelected: true, isLoading: true)) {
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
    on<LoadChaptersContent>((event, emit) async {
      try {
        print("load video");
        emit(state.copyWith(isLoading: true));
        Map<String, dynamic> body = {'auth': event.token};
        print("body..");
        final loginresponce = await ApiRepositoryImpl().getChapterVideo(body: body, id: event.id);

        if (loginresponce["status"] == true) {
          VideoListResponse Response = VideoListResponse.fromJson(loginresponce);
          chapters.clear();
          for (var video in Response.data) {
            chapters.add(ChapterContentModel(VideoUrl: video.videoUrl, imageUrl: video.thumbnailUrl, title: video.videoTitle, subtitle: video.description ?? '', gradeLangEn: '9th English', gradeLangHi: '9th hindi', bgColor: Colors.grey.shade200));
            print(chapters.length);
          }
          emit(state.copyWith(isLoading: false));
          emit(state.copyWith(chapters: chapters));
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(loginresponce["message"])));
          emit(state.copyWith(isLoading: false));
        }
      } on TimeoutException catch (e) {
        print(e);
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
        emit(state.copyWith(isLoading: false));
      } catch (e) {
        emit(state.copyWith(isLoading: false));
        print("error :-$e");
        // emit(state.copyWith(isSubmitting: false, emailError: 'Something went wrong, try again.'));
      }
    });

    on<ToggleLanguageEvent>((event, emit) {
      emit(state.copyWith(isEnglishSelected: !state.isEnglishSelected));
    });
  }
}
