import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../widgets/appBarWidget.dart';

class NotesViewsScreen extends StatefulWidget {
  NotesViewsScreen({super.key, required this.selectName, required this.pdfUrl});

  final String selectName;
  final String pdfUrl;

  @override
  State<NotesViewsScreen> createState() => _NotesViewsScreenState();
}

class _NotesViewsScreenState extends State<NotesViewsScreen> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(appBar: AppBarWidget(appTitle: widget.selectName), backgroundColor: const Color(0xFFF2F5FA), body: SafeArea(child: SfPdfViewer.network(widget.pdfUrl)));
  }
}

// BlocBuilder<NotesBloc, NotesState>(
// builder: (context, state) {
// if (state is LoadedNotes && state.subjectsbloc != null) {
// final uniqueSubjects = state.subjectsbloc!.toSet().toList();
// return DropdownButton<String>(
// value: uniqueSubjects.contains(selectSubject) ? selectSubject : null,
// underline: SizedBox(),
// isDense: true,
// isExpanded: true,
// hint: Text("Select Subject"),
// items: uniqueSubjects.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
// onChanged: (value) {
// if (value != null) {
// context.read<NotesBloc>().add(SelectSubject(value));
// }
// },
// );
// }
// return SizedBox(); // Or CircularProgressIndicator();
// },
// ),

// abstract class NotesState {}
//
// class IsinitialNotes extends NotesState {}
//
// class IsLoadigNotes extends NotesState {}
//
// class LoadedNotes extends NotesState {
//   List<String>? subjectsbloc;
//   LoadedNotes({this.subjectsbloc});
// }
//
// class FailNotes extends NotesState {}
//
// class IsinitialNotesClass extends NotesState {}
//
// class IsLoadigNotesClass extends NotesState {}
//
// class LoadedNotesClass extends NotesState {
//   List<String>? Classbloc;
//   LoadedNotesClass({this.Classbloc});
// }
//
// class FailNotesClass extends NotesState {}

// Future<void> _onGetSubject(GetSubject event, Emitter<NotesState> emit) async {
//   try {
//     print("Loading subjects...");
//     // emit(state.copyWith(isLoadingSubject: true, classes: []));
//
//     Map<String, dynamic> body = {'auth': event.token};
//     final loginResponse = await ApiRepositoryImpl().getSubject(body: body, id: event.id);
//
//     if (loginResponse["status"] == true) {
//       SubjectResponse subjectList = SubjectResponse.fromJson(loginResponse);
//
//       // This is now a list of SubjectData (not just subjectName strings)
//       List<String> subjectModels = subjectList.data.map((e) => e.subjectName).toList();
//       emit(LoadedNotes(subjectsbloc: subjectModels));
//       //  emit(state.copyWith(isLoadingSubject: false, classes: [], subject: subjectModels));
//
//       //print("Subjects loaded: ${state.subject}");
//     } else {
//       ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(loginResponse["message"] ?? "Failed to load subjects.")));
//       // emit(state.copyWith(isLoadingSubject: false, classes: []));
//     }
//   } on TimeoutException {
//     //emit(state.copyWith(isLoadingSubject: false, classes: []));
//     ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
//   } catch (e) {
//     print("Error loading subjects: $e");
//     //  emit(state.copyWith(isLoadingSubject: false, classes: []));
//   }
// }
