import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'image_slider_event.dart';
import 'image_slider_state.dart';

class ImageSliderBloc extends Bloc<ImageSliderEvent, ImageSliderState> {
  final int itemCount;
  Timer? _timer;

  ImageSliderBloc({required this.itemCount}) : super(ImageSliderState(currentIndex: 0)) {
    on<StartSliderEvent>((event, emit) {
      _startTimer();
    });

    on<NextImageEvent>((event, emit) {
      final nextIndex = (state.currentIndex + 1) % itemCount;
      emit(ImageSliderState(currentIndex: nextIndex));
    });

    on<SelectImageEvent>((event, emit) {
      print(event.index);
      emit(ImageSliderState(currentIndex: event.index));
      _restartTimer();
    });

    add(StartSliderEvent());
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      add(NextImageEvent());
    });
  }

  void _restartTimer() {
    _startTimer();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
