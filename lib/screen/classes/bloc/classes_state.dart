import '../models/class_list_model.dart';

abstract class ClassListState {}

class InitailClassList extends ClassListState {}

class IsLoadingClassList extends ClassListState {}

class LoadedClassList extends ClassListState {
  ClassListResponse? classListResponse;
  LoadedClassList({this.classListResponse});
}

class FailClassList extends ClassListState {}
