import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_nav_event.dart';
import 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  int _currentIndex = 0;

  BottomNavBloc() : super(BottomNavInitial()) {
    on<BottomNavItemTapped>(_onBottomNavItemTapped);
    on<BottomNavReset>(_onBottomNavReset);
  }

  void _onBottomNavItemTapped(BottomNavItemTapped event, Emitter<BottomNavState> emit) {
    _currentIndex = event.index;
    emit(BottomNavItemSelected(event.index, event.tabName));
  }

  void _onBottomNavReset(BottomNavReset event, Emitter<BottomNavState> emit) {
    _currentIndex = 0;
    emit(BottomNavInitial());
  }

  int get currentIndex => _currentIndex;
}
