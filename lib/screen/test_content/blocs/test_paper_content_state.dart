import '../models/test_papar_model.dart';

abstract class TestPaperContentState {}

class InitailTestPaperContent extends TestPaperContentState {}

class IsLoadingTestPaperContent extends TestPaperContentState {}

class LoadedTestPaperContent extends TestPaperContentState {
  TestPaperResponse? testPaperResponse;
  LoadedTestPaperContent({this.testPaperResponse});
}

class FailTestPaperContent extends TestPaperContentState {}
