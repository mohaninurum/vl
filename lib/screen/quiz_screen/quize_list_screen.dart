// // --- Classes Screen ---
// class ClassesScreen extends StatelessWidget {
//   String selectClassesName;
//   ClassesScreen({required this.selectClassesName, super.key});
//
//   final List<BottomNavItemModel> navItems = [BottomNavItemModel(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'), BottomNavItemModel(icon: Icons.rss_feed_outlined, activeIcon: Icons.rss_feed, label: 'Feedback'), BottomNavItemModel(icon: Icons.phone_outlined, activeIcon: Icons.phone, label: 'Contact'), BottomNavItemModel(icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profile')];
//   @override
//   Widget build(BuildContext context) {
//     final media = MediaQuery.of(context).size;
//     return Scaffold(backgroundColor: const Color(0xFFF2F5FA), body: SafeArea(child: SingleChildScrollView(padding: EdgeInsets.symmetric(horizontal: media.width * 0.04, vertical: media.height * 0.02), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [SizedBox(height: media.height * 0.02), BannerWidget(categoryName: selectClassesName, screenName: "Classes"), SizedBox(height: media.height * 0.035), const Text(AppString.chooseClassesText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.appBlack54Color)), SizedBox(height: media.height * 0.025), GridviewListWidget(screenName: "Classes")]))), bottomNavigationBar: CustomBottomNavigation(items: navItems));
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constant/app_colors/app_colors.dart';
import '../../../constant/app_text_colors/app_text_colors.dart';
import '../../../constant/widgets/subscription_dialog.dart';
import '../all_content/bloc/quiz_chapter/qiuz_chapter_bloc.dart';
import '../all_content/bloc/quiz_chapter/qiuz_chapter_event.dart';
import '../all_content/bloc/quiz_chapter/qiuz_chapter_state.dart';
import '../auth/login_screen/blocs/login_bloc.dart';
import '../quiz/quiz_screen/quize_screen.dart';
import '../widgets/appBarWidget.dart';

class QuizeListScreen extends StatefulWidget {
  final String selectClassesName;
  final String subject;
  final String selectChapterName;
  final String id;
  const QuizeListScreen({required this.id, required this.subject, required this.selectClassesName, super.key, required this.selectChapterName});

  @override
  State<QuizeListScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<QuizeListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isEnglish = true;
  String language = 'English';
  @override
  void initState() {
    super.initState();
    final token = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.token.toString() ?? '';
    context.read<QiuzChapterBloc>().add(LoadedChapterQuiz(token: token, context: context, id: widget.id));
    _tabController = TabController(length: 4, vsync: this);

    // Correct usage
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPurchase = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.isSubscribe.toString();
    final media = MediaQuery.of(context).size;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBarWidget(appTitle: "Quiz"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: LinearGradient(colors: [AppColors.pramarycolor, AppColors.pramarycolor1], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            padding: EdgeInsets.all(media.width * 0.04),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [Text("Class:", style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 15, fontWeight: FontWeight.w600)), Text(widget.selectClassesName, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 11, fontWeight: FontWeight.w500))]),
                      Row(children: [Text("Subject:", style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 15, fontWeight: FontWeight.w600)), Text(widget.subject, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 11, fontWeight: FontWeight.w500))]),
                      Row(
                        children: [
                          Text("Chapter:", style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 15, fontWeight: FontWeight.w600)),
                          SizedBox(width: media.width * 0.35, child: Column(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.start, children: [Text(widget.selectChapterName, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 11, fontWeight: FontWeight.w500))])),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Image.asset('assets/appicons/quiz_icon.png', height: media.height * 0.12),
              ],
            ),
          ),

          BlocBuilder<QiuzChapterBloc, QiuzChapterState>(
            builder: (context, state) {
              if (state is LoadingQuizState) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is LoadedQuizState) {
                return Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.questions?.data.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
                          // elevation: 4,
                          // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              if (state.questions?.data[index].isPaid.toString() == "1") {
                                if (isPurchase == '1') {
                                  SubscriptionDialog.show(context);
                                } else if (isPurchase == "2") {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen(isPreview: false, id: state.questions?.data[index].quizId, selectClassesName: widget.selectClassesName, tabtype: 'Quiz', selectChapterName: widget.selectChapterName, language: widget.subject)));
                                }
                              } else if (state.questions?.data[index].isPaid.toString() == "2") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen(isPreview: false, id: state.questions?.data[index].quizId, selectClassesName: widget.selectClassesName, tabtype: 'Quiz', selectChapterName: widget.selectChapterName, language: widget.subject)));
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  // Quiz Icon or Initial
                                  Container(height: 48, width: 48, decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.quiz, color: Colors.blueAccent, size: 28)),

                                  const SizedBox(width: 16),

                                  // Title and optional tag
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(state.questions?.data[index].title ?? 'Untitled Quiz', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)), const SizedBox(height: 6),
                                        //   Text("Created on: ${state.questions?.data[index].createdAt ?? ''}", style: TextStyle(fontSize: 13, color: Colors.grey[600]))
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child:
                                        (state.questions?.data[index].isPaid == 1)
                                            ? isPurchase == "2"
                                                ? SizedBox()
                                                : Icon(Icons.lock, color: Colors.redAccent.shade200)
                                            : SizedBox(), //item?.isPaid == "1"
                                    // : item?.isPurchase == "2"
                                    // ? Icon(Icons.lock_open, color: Colors.green)
                                    // : SizedBox(),
                                  ),
                                  // Paid/Free Tag or Arrow
                                  // Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: (state.questions?.data[index].isPaid == 1) ? Colors.red[50] : Colors.green[50], borderRadius: BorderRadius.circular(8)), child: Text(state.questions?.data[index].isPaid == 1 ? "Paid" : "Free", style: TextStyle(color: state.questions?.data[index].isPaid == 1 ? Colors.red : Colors.green, fontSize: 12, fontWeight: FontWeight.bold))),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // Text(AppString.quetionForPracticeText),
                    // SizedBox(height: media.height * 0.015),
                    // CustomButton(
                    //   onPressed: () {
                    //     Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen(isPreview: false, id: widget.id, selectClassesName: widget.selectClassesName, tabtype: 'Quiz', selectChapterName: widget.selectChapterName, language: widget.language)));
                    //   },
                    //   text: "Start Quiz",
                    //   color: AppColors.buttonColorBlue1,
                    //   textColor: AppColors.appWhiteColor,
                    // ),
                  ],
                );
              }
              return SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
