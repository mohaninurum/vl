import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../auth/login_screen/blocs/login_bloc.dart';
import '../../notes_content/blocs/notes_content_bloc.dart';
import '../../notes_content/blocs/notes_content_event.dart';
import '../../notes_content/blocs/notes_content_state.dart';
import '../../test_content/blocs/test_paper_content_bloc.dart';
import '../../test_content/blocs/test_paper_content_event.dart';
import '../../test_content/blocs/test_paper_content_state.dart';
import '../../widgets/appBarWidget.dart';

class NotesViewsScreen extends StatefulWidget {
  NotesViewsScreen({super.key, required this.selectName, this.id});
  final String selectName;
  final id;

  @override
  State<NotesViewsScreen> createState() => _NotesViewsScreenState();
}

class _NotesViewsScreenState extends State<NotesViewsScreen> {
  @override
  void initState() {
    final token = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.token.toString() ?? '';
    if (widget.selectName == "Test Paper") {
      context.read<TestPaperContentBloc>().add(LoadTestPaperContent(id: widget.id, context: context, token: token));
    } else {
      context.read<NotesContentBloc>().add(LoadNotesContent(id: widget.id, context: context, token: token));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(appTitle: widget.selectName),
      backgroundColor: const Color(0xFFF2F5FA),
      body: SafeArea(
        child:
            widget.selectName == "Test Paper"
                ? BlocBuilder<TestPaperContentBloc, TestPaperContentState>(
                  builder: (context, state) {
                    if (state is IsLoadingTestPaperContent) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is LoadedTestPaperContent) {
                      return state.testPaperResponse?.data.length != 0 ? SfPdfViewer.network(state.testPaperResponse?.data[0].pdfUrl ?? '') : Center(child: Text("No Record"));
                    }
                    if (state is FailTestPaperContent) {
                      return Center(child: Text("Not Found"));
                    }
                    return SizedBox();
                  },
                )
                : BlocBuilder<NotesContentBloc, NotesContentState>(
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
