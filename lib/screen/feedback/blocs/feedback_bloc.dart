import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/feedback_model.dart';
import 'feedback_event.dart';
import 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc() : super(FeedbackState(feedbacks: [])) {
    on<SubmitFeedback>((event, emit) {
      final newFeedback = FeedbackModel(name: event.name, message: event.message, time: DateTime.now());
      emit(FeedbackState(feedbacks: [...state.feedbacks, newFeedback]));
    });
  }
}
