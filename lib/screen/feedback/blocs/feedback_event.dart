abstract class FeedbackEvent {}

class SubmitFeedback extends FeedbackEvent {
  final String name;
  final String message;

  SubmitFeedback(this.name, this.message);
}
