import '../models/feedback_list_model.dart';

class FeedbackState {
  final FeedbackResponse? feedbacks;
  bool isSubmitting;
  bool isLoading;
  FeedbackState({this.feedbacks, required this.isSubmitting, required this.isLoading});

  FeedbackState copyWith({FeedbackResponse? feedbacks, required bool isSubmitting, required bool isLoading}) {
    return FeedbackState(feedbacks: feedbacks ?? this.feedbacks, isSubmitting: isSubmitting, isLoading: isLoading);
  }
}
