import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constant/app_colors/app_colors.dart';
import '../../../constant/app_string/app_string.dart';
import '../../../constant/app_text_colors/app_text_colors.dart';
import '../../auth/login_screen/blocs/login_bloc.dart';
import '../../test_paper/test_paper_screen/test_paper_views_screen.dart';
import '../../widgets/appBarWidget.dart';
import '../blocs/get_notes/get_notes_list_bloc.dart';
import '../blocs/get_notes/get_notes_list_event.dart';
import '../blocs/get_notes/get_notes_list_state.dart';
import '../blocs/get_subject/get_subject_bloc.dart';
import '../blocs/get_subject/get_subject_event.dart';
import '../blocs/get_subject/get_subject_state.dart';
import '../blocs/notes_bloc/notes_bloc.dart';
import '../blocs/notes_bloc/notes_event.dart';
import '../blocs/notes_bloc/notes_state.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key, this.selectsName, this.id});
  final selectsName;
  final id;
  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  // List<String> classes = ['9th', '10th'];
  String selectSubject = "Select Subject";
  String selectClass = "Select Class";
  List<String> subjectsbloc = [];
  late String token;
  @override
  void initState() {
    super.initState();
    token = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.token.toString() ?? '';
    context.read<NotesBloc>().add(GetClasses(id: widget.id, context: context, token: token));
    context.read<GetSubjectBloc>().add(GetSubject(token: token, id: "0", context: context));
    context.read<GetNotesListBloc>().add(GetNotesList(id: "", token: token, context: context, selectSubject: selectSubject));

    // context.read<NotesBloc>().add(LoadNotes());
    // context.read<NotesBloc>().add(GetSubject(id: '9', token: token));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      appBar: AppBarWidget(appTitle: widget.selectsName),
      backgroundColor: const Color(0xFFF2F5FA),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: width * 0.02),
        child: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            if (state is IsLoadigNotesClass) {
              return Center(child: CircularProgressIndicator());
            }
            //  if (state is LoadedNotesClass) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: LinearGradient(colors: [AppColors.pramarycolor, AppColors.pramarycolor1], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                  padding: EdgeInsets.all(width * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [Text(widget.selectsName, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 15, fontWeight: FontWeight.w600)), Text("For all classes", style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 13, fontWeight: FontWeight.w600))]),
                      Spacer(),
                      Image.asset('assets/appicons/digital notesAsset 1.png', height: height * 0.12),
                    ],
                  ),
                ),

                SizedBox(height: height * 0.015),
                Text(AppString.AllContentText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.appBlack54Color)),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(color: AppColors.appWhiteColor, border: Border.all(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                          child: BlocBuilder<NotesBloc, NotesState>(
                            builder: (context, state) {
                              if (state is LoadedNotesClass && state.Classbloc != null) {
                                final uniqueSubjects = state.Classbloc!.toSet().toList();
                                return DropdownButton<String>(
                                  value: uniqueSubjects.contains(selectClass) ? selectClass : null,
                                  underline: SizedBox(),
                                  isDense: true,
                                  isExpanded: true,
                                  hint: Text(selectClass),
                                  items: uniqueSubjects.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      selectClass = value;

                                      selectSubject = "Select Subject";
                                      setState(() {});
                                      var classId = BlocProvider.of<NotesBloc>(context).classListResponse?.data.firstWhere((element) => element.className == value).classId;
                                      context.read<GetSubjectBloc>().add(GetSubject(token: token, id: "$classId", context: context));
                                      context.read<GetNotesListBloc>().add(GetNotesList(id: value, token: token, context: context, selectSubject: selectSubject));

                                      // context.read<NotesBloc>().add(SelectSubject(value));
                                      // setState(() {});
                                    }
                                  },
                                );
                              }
                              return DropdownButton<String>(
                                value: selectClass,
                                underline: SizedBox(),
                                isDense: true,
                                hint: Text(selectClass),
                                isExpanded: true, //
                                items: subjectsbloc.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                                onChanged: (value) {},
                              ); // Or CircularProgressIndicator();
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(color: AppColors.appWhiteColor, border: Border.all(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                          child: BlocBuilder<GetSubjectBloc, NotesSubjectState>(
                            builder: (context, state) {
                              if (state is LoadedNotesSubject && state.subjectsbloc != null) {
                                final uniqueSubjects = state.subjectsbloc!.toSet().toList();
                                return DropdownButton<String>(
                                  value: uniqueSubjects.contains(selectSubject) ? selectSubject : null,
                                  underline: SizedBox(),
                                  isDense: true,
                                  isExpanded: true,
                                  hint: Text(selectSubject),
                                  items: uniqueSubjects.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      // var classId = BlocProvider.of<GetSubjectBloc>(context).subjectList?.data.firstWhere((element) => element.subjectName == value).classId;
                                      // print(classId);
                                      selectSubject = value;
                                      setState(() {});
                                      context.read<GetNotesListBloc>().add(GetNotesList(id: value, token: token, context: context, selectSubject: selectSubject));
                                      // context.read<NotesBloc>().add(SelectSubject(value));
                                    }
                                  },
                                );
                              }
                              return DropdownButton<String>(
                                value: selectSubject,
                                underline: SizedBox(),
                                isDense: true,
                                hint: Text(selectSubject),
                                isExpanded: true, //
                                items: subjectsbloc.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                                onChanged: (value) {},
                              );
                              // Or CircularProgressIndicator();
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () {
                          context.read<NotesBloc>().add(LoadNotes());
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                Expanded(
                  child: BlocBuilder<GetNotesListBloc, GetNotesListState>(
                    builder: (context, state) {
                      if (state is IsLoadingGetNotesList) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (state is LoadedGetNotesList) {
                        return state.filteredNotes.isNotEmpty
                            ? ListView.builder(
                              itemCount: state.filteredNotes.length,
                              itemBuilder: (context, index) {
                                final note = state.filteredNotes[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2.5),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => NotesViewsScreen(selectName: widget.selectsName, id: state.filteredNotes[index].id)));
                                    },
                                    child: Container(color: AppColors.lightpurplecolor, child: ListTile(dense: true, minTileHeight: height * 0.02, leading: const Icon(Icons.note_alt_outlined, color: Colors.purple), title: Text('${index + 1}. ${note.title}', style: TextStyle(fontSize: 13)), subtitle: Text('${note.className} Notes', style: TextStyle(fontSize: 12)), trailing: const Icon(Icons.visibility, color: Colors.purple))),
                                  ),
                                );
                              },
                            )
                            : Center(child: Text("No Record"));
                      }
                      return SizedBox();
                    },
                  ),
                ),
              ],
            );
            // }
            //  return SizedBox(child: Text("Error"));
          },
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(items: const [BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'), BottomNavigationBarItem(icon: Icon(Icons.feedback), label: 'Feedback'), BottomNavigationBarItem(icon: Icon(Icons.contact_phone), label: 'Contact'), BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')], selectedItemColor: Colors.purple, unselectedItemColor: Colors.grey, showUnselectedLabels: true),
    );
  }
}
