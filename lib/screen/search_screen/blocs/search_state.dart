import '../models/responce_model.dart';

abstract class SearchState {}

class ContentLoading extends SearchState {}

class ContentInitial extends SearchState {}

class ContentLoaded extends SearchState {
  final List<VideoItem> videos;
  final List<NoteItem> notes;
  final List<TestPaperItem> pdfs;

  ContentLoaded({required this.videos, required this.notes, required this.pdfs});
}
