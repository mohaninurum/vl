import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repo/api_repository_lmp.dart';
import '../../auth/login_screen/blocs/login_bloc.dart';
import '../model/all_content_model.dart';
import 'all_content_event.dart';
import 'all_content_state.dart';

class ChapterContentBloc extends Bloc<ChapterContentEvent, ChapterContentState> {
  // final chapters = [
  //   ChapterContentModel(imageUrl: 'https://img.youtube.com/vi/fq4N0hgOWzU/0.jpg', title: '1. Motion', subtitle: 'Chapter: Motion', gradeLang: '9th English', bgColor: Colors.grey.shade200),
  //   ChapterContentModel(imageUrl: 'https://img.youtube.com/vi/fq4N0hgOWzU/1.jpg', title: '2. Motion along a straight line', subtitle: 'Chapter: Motion', gradeLang: '9th English', bgColor: Colors.grey.shade200),
  //   ChapterContentModel(imageUrl: 'https://img.youtube.com/vi/fq4N0hgOWzU/2.jpg', title: '3. Uniform and non uniform motion ', subtitle: 'Chapter: Motion', gradeLang: '9th English', bgColor: Colors.grey.shade300),
  //   ChapterContentModel(imageUrl: 'https://img.youtube.com/vi/fq4N0hgOWzU/3.jpg', title: '4. Basic terms use in motion', subtitle: 'Chapter: Motion', gradeLang: '9th English', bgColor: Colors.grey.shade300),
  // ];
  final chapters = [ChapterContentModel(videoId: "1", isPaid: '1', imageUrl: 'https://img.youtube.com/vi/fq4N0hgOWzU/0.jpg', title: 'Motion', subtitle: 'Chapter: Motion', gradeLangEn: '9th English', gradeLangHi: '9th hindi', bgColor: Colors.grey.shade200)];

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
    on<FavoriteEvent>((event, emit) async {
      String languageType = "1";
      final newFavorites = Set<int>.from(state.favoriteIndexes);
      final updatedChapters = List<ChapterContentModel>.from(state.chapters);

      final currentItem = updatedChapters[event.selectIndex];
      final isCurrentlyFavorited = currentItem.isFavorited ?? false;

      emit(state.copyWith(isLoading2: true));
      print(event.languageType);
      if (event.languageType.toString().contains("Hindi")) {
        languageType = "1";
        print("inside if");
      } else {
        languageType = "2";
        print("inside else");
      }
      try {
        final body = {'auth': event.token, 'user_id': event.userID, 'video_id': event.favoriteID, "language_type": languageType};
        print(body);
        final response = isCurrentlyFavorited ? await ApiRepositoryImpl().removeFavoriteVideo(body: body) : await ApiRepositoryImpl().addFavoriteVideo(body: body);

        if (response["status"] == true) {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(response["message"])));

          updatedChapters[event.selectIndex] = currentItem.copyWith(isFavorited: !isCurrentlyFavorited);

          if (isCurrentlyFavorited) {
            newFavorites.remove(event.selectIndex);
          } else {
            newFavorites.add(event.selectIndex);
          }

          emit(state.copyWith(chapters: updatedChapters, favoriteIndexes: newFavorites, selectIndex: event.selectIndex, isLoading2: false));
        } else {
          emit(state.copyWith(isLoading2: false));
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(response["message"] ?? 'Something went wrong')));
        }
      } on TimeoutException {
        emit(state.copyWith(isLoading2: false));
        ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(content: Text('Request timed out. Please try again.')));
      } catch (e) {
        emit(state.copyWith(isLoading2: false));
        print("Error: $e");
        ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(content: Text('Something went wrong.')));
      }
    });

    // on<FavoriteEvent>((event, emit) async {
    //   final newFavorites = Set<int>.from(state.favoriteIndexes);
    //   if (newFavorites.contains(event.selectIndex)) {
    //     print("remove favorite");
    //     try {
    //       print("load video");
    //       emit(state.copyWith(isLoading2: true));
    //       Map<String, dynamic> body = {'auth': event.token, "user_id": event.userID, "video_id": event.favoriteID};
    //       print("body..");
    //       final responce = await ApiRepositoryImpl().removeFavoriteVideo(body: body);
    //
    //       if (responce["status"] == true) {
    //         ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(responce["message"])));
    //         emit(state.copyWith(isLoading2: false));
    //       } else {
    //         ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(responce["message"])));
    //         emit(state.copyWith(isLoading2: false));
    //       }
    //     } on TimeoutException catch (e) {
    //       print(e);
    //       ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
    //       emit(state.copyWith(isLoading2: false));
    //     } catch (e) {
    //       emit(state.copyWith(isLoading2: false));
    //       print("error :-$e");
    //       // emit(state.copyWith(isSubmitting: false, emailError: 'Something went wrong, try again.'));
    //     }
    //     newFavorites.remove(event.selectIndex);
    //   } else {
    //     print("added favorite");
    //     try {
    //       print("load video");
    //       emit(state.copyWith(isLoading2: true));
    //       Map<String, dynamic> body = {'auth': event.token, "user_id": event.userID, "video_id": event.favoriteID};
    //       print("body..");
    //       final responce = await ApiRepositoryImpl().addFavoriteVideo(body: body);
    //
    //       if (responce["status"] == true) {
    //         ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(responce["message"])));
    //         emit(state.copyWith(isLoading2: false));
    //       } else {
    //         ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(responce["message"])));
    //         emit(state.copyWith(isLoading2: false));
    //       }
    //     } on TimeoutException catch (e) {
    //       print(e);
    //       ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
    //       emit(state.copyWith(isLoading2: false));
    //     } catch (e) {
    //       emit(state.copyWith(isLoading2: false));
    //       print("error :-$e");
    //       // emit(state.copyWith(isSubmitting: false, emailError: 'Something went wrong, try again.'));
    //     }
    //     newFavorites.add(event.selectIndex);
    //   }
    //
    //   emit(state.copyWith(favoriteIndexes: newFavorites, selectIndex: event.selectIndex));
    // });

    // on<FavoriteEvent>((event, emit) {
    //   emit(state.copyWith(isFavorite: event.isfavorite));
    // });
    on<LoadChaptersContent>((event, emit) async {
      try {
        print("load video");
        emit(state.copyWith(isLoading: true));
        Map<String, dynamic> body = {'auth': event.token};
        print("body..");
        final responce = await ApiRepositoryImpl().getChapterVideo(body: body, id: event.id, userID: event.userID);

        if (responce["status"] == true) {
          VideoListResponse Response = VideoListResponse.fromJson(responce);
          chapters.clear();
          for (var video in Response.data) {
            chapters.add(ChapterContentModel(isFavorited: video.isFavourite.toString() == "1" ? true : false, videoId: video.videoIdPk.toString(), videoUrlEnglish: video.videoUrlEnglish, videoUrlHindi: video.videoUrlHindi, videoType: video.videoType.toString(), isPurchase: BlocProvider.of<LoginBloc>(event.context).loginResponse?.user?.isSubscribe.toString(), isPaid: video.isPaid.toString(), imageUrl: video.thumbnailUrl, title: video.videoTitle, subtitle: video.description ?? '', gradeLangEn: 'English', gradeLangHi: 'hindi', bgColor: Colors.grey.shade200));
            print(chapters.length);
          }
          emit(state.copyWith(isLoading: false));
          emit(state.copyWith(chapters: chapters));
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(responce["message"])));
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
