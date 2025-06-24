import 'package:flutter_bloc/flutter_bloc.dart';

import '_category_selected_event.dart';
import '_category_selected_state.dart';

class CategorySelectedBloc extends Bloc<CategorySelectedEvent, CategorySelectedState> {
  CategorySelectedBloc() : super(CategorySelectedState(selectedCategory: '', id: '')) {
    on<CategorySelected>((event, emit) {
      emit(CategorySelectedState(selectedCategory: event.category, id: event.id));
    });
  }
}
