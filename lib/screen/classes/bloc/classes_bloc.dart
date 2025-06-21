import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repo/api_repository_lmp.dart';
import '../../auth/login_screen/blocs/login_bloc.dart';
import 'classes_event.dart';
import 'classes_state.dart';

class ClassListBloc extends Bloc<ClassListEvent, ClassListState> {
  ClassListBloc() : super(InitailClassList()) {
    on<LoadClassList>((event, emit) async {
      try {
        emit(LoadedClassList());
        Map<String, dynamic> body = {'auth': BlocProvider.of<LoginBloc>(event.context).loginResponse?.user?.token.toString() ?? ''};
        final loginresponce = await ApiRepositoryImpl().getClassListByCategory(body: body, id: event.id);
        if (loginresponce["status"] == true) {
          // CategoryResponseModel loginResponse = CategoryResponseModel.fromJson(loginresponce);
          // emit(LoadedClassList(categoryResponseModel: loginResponse));
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(loginresponce["message"])));
          emit(FailClassList());
        }
      } on TimeoutException catch (e) {
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
      } catch (e) {
        emit(FailClassList());
        print("error :-$e");
        // emit(state.copyWith(isSubmitting: false, emailError: 'Something went wrong, try again.'));
      }
    });
  }
}
