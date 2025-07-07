// blocs/favorite_bloc.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repo/api_repository_lmp.dart';
import '../../auth/login_screen/blocs/login_bloc.dart';
import '../models/models.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

enum FavoriteCategory { Video }

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteState(selectedCategory: FavoriteCategory.Video, allFavorites: [], isLoading: false)) {
    on<ChangeCategory>((event, emit) {
      emit(state.copyWith(selectedCategory: event.category, isLoading: false));
    });

    on<LoadFavorites>((event, emit) async {
      final FavoriteData = [
        FavoriteItem(isPurchase: '', type: 'video', videoType: '2', title: 'testing video ', subtitle: 'Description', thumbnailUrl: 'http://157.245.100.207:3001/uploads/thumbnails/1751525928474.png', videoUrlHindi: 'https://www.youtube.com/watch?v=AHFBK0YDk3s&list=PLdb6KKzTz-by4IuO4qsG8JZokr4ouvFH4', isPaid: '1'), //
      ];
      try {
        print("load video");
        emit(state.copyWith(isLoading: true));
        Map<String, dynamic> body = {'auth': event.token};
        print("body..");
        final responce = await ApiRepositoryImpl().favoriteVideo(body: body, id: event.userID);

        if (responce["status"] == true) {
          FavoriteVideoResponse Response = FavoriteVideoResponse.fromJson(responce);
          FavoriteData.clear();
          for (var video in Response.data) {
            FavoriteData.add(FavoriteItem(isPurchase: BlocProvider.of<LoginBloc>(event.context).loginResponse?.user?.isSubscribe.toString(), type: "Video", videoUrlEnglish: video.videoUrlEnglish ?? '', videoUrlHindi: video.videoUrlHindi ?? '', videoType: video.videoType.toString(), isPaid: video.isPaid.toString(), thumbnailUrl: video.thumbnailUrl, title: video.videoTitle, subtitle: video.description));
          }
          emit(state.copyWith(isLoading: false, allFavorites: FavoriteData));
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
  }
}
