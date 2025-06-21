import '../models/feedback_model.dart';

class FeedbackState {
  final List<FeedbackModel> feedbacks;
  FeedbackState({required this.feedbacks});

  FeedbackState copyWith({List<FeedbackModel>? feedbacks}) {
    return FeedbackState(feedbacks: feedbacks ?? this.feedbacks);
  }
}
