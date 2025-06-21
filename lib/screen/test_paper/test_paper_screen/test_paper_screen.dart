import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constant/app_colors/app_colors.dart';
import '../../../constant/app_string/app_string.dart';
import '../../../constant/app_text_colors/app_text_colors.dart';
import '../../widgets/appBarWidget.dart';
import '../blocs/test_paper_bloc.dart';
import '../blocs/test_paper_event.dart';
import '../blocs/test_paper_state.dart';
import 'test_paper_views_screen.dart';

class TestPaperScreen extends StatefulWidget {
  const TestPaperScreen({super.key, this.selectsName});
  final selectsName;
  @override
  State<TestPaperScreen> createState() => _TestPaperScreenState();
}

class _TestPaperScreenState extends State<TestPaperScreen> {
  final List<String> classes = ['9th', '10th'];
  final List<String> subjects = ['Science', 'Biology'];

  @override
  void initState() {
    super.initState();
    context.read<TestPaperBloc>().add(LoadTestPaper());
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
        child: BlocBuilder<TestPaperBloc, TestPaperState>(
          builder: (context, state) {
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
                      Image.asset('assets/appicons/icon23Asset 1.png', height: height * 0.12),
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
                          child: DropdownButton<String>(
                            underline: SizedBox(),
                            value: state.selectedClass,
                            isExpanded: true,
                            isDense: true,
                            items: classes.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                context.read<TestPaperBloc>().add(SelectClass(value));
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(color: AppColors.appWhiteColor, border: Border.all(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton<String>(
                            value: state.selectedSubject,
                            underline: SizedBox(),
                            isDense: true,
                            isExpanded: true,
                            items: subjects.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                context.read<TestPaperBloc>().add(SelectSubject(value));
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () {
                          context.read<TestPaperBloc>().add(LoadTestPaper());
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.filteredTestPaper.length,
                    itemBuilder: (context, index) {
                      final note = state.filteredTestPaper[index];
                      String pdfUrl = 'https://gbihr.org/images/docs/test.pdf';
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.5),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => NotesViewsScreen(selectName: widget.selectsName, pdfUrl: pdfUrl)));
                          },
                          child: Container(color: AppColors.lightpurplecolor, child: ListTile(dense: true, minTileHeight: height * 0.02, leading: const Icon(Icons.note_alt_outlined, color: Colors.purple), title: Text('${index + 1}. ${note.title}', style: TextStyle(fontSize: 13)), subtitle: Text('${note.className} Notes', style: TextStyle(fontSize: 12)), trailing: const Icon(Icons.visibility, color: Colors.purple))),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(items: const [BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'), BottomNavigationBarItem(icon: Icon(Icons.feedback), label: 'Feedback'), BottomNavigationBarItem(icon: Icon(Icons.contact_phone), label: 'Contact'), BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')], selectedItemColor: Colors.purple, unselectedItemColor: Colors.grey, showUnselectedLabels: true),
    );
  }
}
