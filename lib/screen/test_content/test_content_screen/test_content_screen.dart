import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:visual_learning/constant/app_colors/app_colors.dart';

import '../../../constant/widgets/subscriptions_button_widgets.dart';
import '../../auth/login_screen/blocs/login_bloc.dart';
import '../../widgets/appBarWidget.dart';
import '../blocs/test_paper_content_bloc.dart';
import '../blocs/test_paper_content_event.dart';
import '../blocs/test_paper_content_state.dart';

class TestContentDetialScreen extends StatefulWidget {
  TestContentDetialScreen({required this.language, required this.selectClassName, required this.selectChapterName, super.key, required this.tabtype, required this.id});
  final String language;
  final String selectClassName;
  final String selectChapterName;
  final String tabtype;
  final String id;

  @override
  State<TestContentDetialScreen> createState() => _VideoContentDetailScreenState();
}

class _VideoContentDetailScreenState extends State<TestContentDetialScreen> {
  String subscription = '1';
  @override
  void initState() {
    final token = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.token.toString() ?? '';
    subscription = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.isSubscribe.toString() ?? '';
    context.read<TestPaperContentBloc>().add(LoadTestPaperContent(id: widget.id, context: context, token: token));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var indexget = widget.selectClassName.indexOf('h');
    final screenWidth = MediaQuery.of(context).size.width;
    print(indexget);
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(appTitle: '${widget.selectClassName.substring(0, indexget + 1)} ${widget.tabtype}'),
      backgroundColor: const Color(0xFFF2F5FA),
      body: SafeArea(
        child: //
            Container(
          decoration: BoxDecoration(border: Border.all(color: AppColors.pramarycolor)),
          child: Padding(
            padding: const EdgeInsets.all(8.0), //
            child: BlocBuilder<TestPaperContentBloc, TestPaperContentState>(
              builder: (context, state) {
                if (state is IsLoadingTestPaperContent) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is LoadedTestPaperContent) {
                  return state.testPaperResponse?.data.length != 0
                      ? state.testPaperResponse?.data[0].isPaid.toString() == "1"
                          ? subscription == "1"
                              ? SubscriptionsButtonWidgets()
                              : SfPdfViewer.network(state.testPaperResponse?.data[0].pdfUrl ?? '')
                          : SfPdfViewer.network(state.testPaperResponse?.data[0].pdfUrl ?? '') //
                      : Center(child: Text("No Record"));
                }

                if (state is FailTestPaperContent) {
                  return Center(child: Text("Not Found"));
                }
                return SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
