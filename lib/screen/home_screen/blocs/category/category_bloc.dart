import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repo/api_repository_lmp.dart';
import '../../../auth/login_screen/blocs/login_bloc.dart';
import '../../model/category_model.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryClicked>((event, emit) {});
    on<LoadCategory>((event, emit) async {
      try {
        emit(IsLoadingCategory());
        Map<String, dynamic> body = {'auth': BlocProvider.of<LoginBloc>(event.context).loginResponse?.user?.token.toString() ?? ''};
        final loginresponce = await ApiRepositoryImpl().getCategory(body: body);
        if (loginresponce["status"] == true) {
          CategoryResponseModel loginResponse = CategoryResponseModel.fromJson(loginresponce);
          emit(LoadedCategoryState(categoryResponseModel: loginResponse));
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(loginresponce["message"])));
          emit(FialdCategoryState());
        }
      } catch (e) {
        emit(FialdCategoryState());
        print("error :-$e");
        // emit(state.copyWith(isSubmitting: false, emailError: 'Something went wrong, try again.'));
      }
    });
  }
}
