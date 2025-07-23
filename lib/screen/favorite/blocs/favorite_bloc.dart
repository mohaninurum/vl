// blocs/favorite_bloc.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repo/api_repository_lmp.dart';
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
      try {
        print("load video");
        emit(state.copyWith(isLoading: true));
        Map<String, dynamic> body = {'auth': event.token};
        print("body..");
        final responce = await ApiRepositoryImpl().favoriteVideo(body: body, id: event.userID);

        if (responce["status"] == true) {
          FavoriteVideoListResponse Response = FavoriteVideoListResponse.fromJson(responce);

          emit(state.copyWith(isLoading: false, allFavorites: Response.data));
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
