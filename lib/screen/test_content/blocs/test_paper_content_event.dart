abstract class TestPaperContentEvent {}

class LoadTestPaperContent extends TestPaperContentEvent {
  final context;
  final token;
  String id;
  LoadTestPaperContent({this.token, this.context, required this.id});
}
