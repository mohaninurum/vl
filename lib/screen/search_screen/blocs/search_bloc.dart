import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/screen/search_screen/blocs/search_event.dart';
import 'package:visual_learning/screen/search_screen/blocs/search_state.dart';

import '../../../repo/api_repository_lmp.dart';
import '../models/responce_model.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(ContentInitial()) {
    on<PerformSearch>((event, emit) async {
      try {
        if (event.query.trim().isEmpty) {
          emit(ContentLoaded(videos: [], notes: [], pdfs: [])); // clear results
          return;
        }

        emit(ContentLoading());
        Map<String, dynamic> body = {"keyword": event.query, 'auth': event.token};
        final responce = await ApiRepositoryImpl().getSearchList(body: body);
        if (responce["status"] == true) {
          SearchResponse data = SearchResponse.fromJson(responce);
          emit(
            ContentLoaded(
              videos: data.data?.videoList ?? [],
              notes: data.data?.notesList ?? [], //
              pdfs: data.data?.testPaperList ?? [],
            ),
          );
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(responce["message"])));
        }
      } on TimeoutException catch (e) {
        print(e);
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
      } catch (e) {
        print("error :-$e");
        // emit(state.copyWith(isSubmitting: false, emailError: 'Something went wrong, try again.'));
      }
    });
  }
}
