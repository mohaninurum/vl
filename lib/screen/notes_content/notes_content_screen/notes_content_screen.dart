import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:visual_learning/screen/notes_content/blocs/notes_content_bloc.dart';
import 'package:visual_learning/screen/notes_content/blocs/notes_content_event.dart';

import '../../auth/login_screen/blocs/login_bloc.dart';
import '../../widgets/appBarWidget.dart';
import '../blocs/notes_content_state.dart';

class NotesContentDetialScreen extends StatefulWidget {
  NotesContentDetialScreen({required this.language, required this.selectClassName, required this.selectChapterName, super.key, required this.tabtype, required this.id});
  final String language;
  final String selectClassName;
  final String selectChapterName;
  final String tabtype;
  final String id;

  @override
  State<NotesContentDetialScreen> createState() => _VideoContentDetailScreenState();
}

class _VideoContentDetailScreenState extends State<NotesContentDetialScreen> {
  String pdfUrl = 'https://www.aeee.in/wp-content/uploads/2020/08/Sample-pdf.pdf';

  @override
  void initState() {
    final token = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.token.toString() ?? '';
    context.read<NotesContentBloc>().add(LoadNotesContent(id: widget.id, context: context, token: token));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var indexget = widget.selectClassName.indexOf('h');
    print(indexget);
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(appTitle: '${widget.selectClassName.substring(0, indexget + 1)} ${widget.tabtype}'),
      backgroundColor: const Color(0xFFF2F5FA),
      body: SafeArea(
        child: BlocBuilder<NotesContentBloc, NotesContentState>(
          builder: (context, state) {
            if (state is IsLoadingNotesContent) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is LoadedNotesContent) {
              return state.notesPdfResponse?.data.length != 0 ? SfPdfViewer.network(state.notesPdfResponse?.data[0].pdfUrl ?? '') : Center(child: Text("No Record"));
            }
            if (state is FailNotesContent) {
              return Center(child: Text("Not Found"));
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
