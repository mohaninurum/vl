abstract class FeedbackEvent {}

class SubmitFeedback extends FeedbackEvent {
  final String name;
  final String message;
  final String token;
  final context;

  SubmitFeedback({required this.context, required this.name, required this.message, required this.token});
}

class GetFeedbackList extends FeedbackEvent {
  final String token;
  final context;

  GetFeedbackList({required this.context, required this.token});
}
