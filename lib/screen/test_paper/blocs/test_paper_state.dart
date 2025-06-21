import '../models/test_paper_model.dart';

class TestPaperState {
  final List<TestPaperModel> allTestPaper;
  final String selectedClass;
  final String selectedSubject;
  final List<TestPaperModel> filteredTestPaper;

  TestPaperState({required this.allTestPaper, required this.selectedClass, required this.selectedSubject, required this.filteredTestPaper});

  TestPaperState copyWith({List<TestPaperModel>? allNotes, String? selectedClass, String? selectedSubject, List<TestPaperModel>? filteredNotes}) {
    return TestPaperState(allTestPaper: allNotes ?? this.allTestPaper, selectedClass: selectedClass ?? this.selectedClass, selectedSubject: selectedSubject ?? this.selectedSubject, filteredTestPaper: filteredNotes ?? this.filteredTestPaper);
  }
}

class TestPaperLoading extends TestPaperState {
  TestPaperLoading() : super(allTestPaper: [], selectedClass: '9th', selectedSubject: 'Science', filteredTestPaper: []);
}
