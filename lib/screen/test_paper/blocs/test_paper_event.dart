abstract class TestPaperEvent {}

class LoadTestPaper extends TestPaperEvent {}

class SelectClass extends TestPaperEvent {
  final String className;
  SelectClass(this.className);
}

class SelectSubject extends TestPaperEvent {
  final String subject;
  SelectSubject(this.subject);
}
