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
import 'package:visual_learning/screen/all_content/block/all_content_state.dart';
import 'package:visual_learning/screen/home_screen/blocs/CategorySelected/_category_selected_bloc.dart';
import 'package:visual_learning/screen/home_screen/blocs/CategorySelected/_category_selected_state.dart';

import '../../../constant/app_colors/app_colors.dart';
import '../../../constant/app_string/app_string.dart';
import '../../../constant/app_text_colors/app_text_colors.dart';
import '../../auth/login_screen/blocs/login_bloc.dart';
import '../../chapter/blocs/subjecttab_bloc.dart';
import '../../chapter/blocs/subjecttab_event.dart';
import '../../chapter/blocs/subjecttab_state.dart';
import '../../notes_content/notes_content_screen/notes_content_screen.dart';
import '../../quiz/quiz_screen/quize_screen.dart';
import '../../test_content/test_content_screen/test_content_screen.dart';
import '../../video_content_detail/video_content_detail_screen/video_content_detail_screen.dart';
import '../block/all_content_bloc.dart';
import '../block/all_content_event.dart';
import 'chapter_content_card.dart';
import 'custome_button.dart';

class AllContentWidget extends StatefulWidget {
  final String selectClassesName;
  final String language;
  final String selectChapterName;
  final String id;
  const AllContentWidget({required this.id, required this.language, required this.selectClassesName, super.key, required this.selectChapterName});

  @override
  State<AllContentWidget> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<AllContentWidget> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isEnglish = true;
  String language = 'English';
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
    language = widget.language;

    // Correct usage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var token = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.token.toString();
      final bloc = context.read<ChapterContentBloc>();
      bloc.add(LoadChaptersContent(token: token, id: widget.id, context: context));
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final width = MediaQuery.of(context).size.width;
    return Column(
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
                    Row(children: [Text("Language:", style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 15, fontWeight: FontWeight.w600)), Text(language, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 11, fontWeight: FontWeight.w500))]),
                    Row(children: [Text("Chapter:", style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 15, fontWeight: FontWeight.w600)), Text(widget.selectChapterName, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 11, fontWeight: FontWeight.w500))]),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Image.asset('assets/appicons/icon5Asset 5.png', height: media.height * 0.12),
            ],
          ),
        ),
        SizedBox(height: media.height * 0.035),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppString.AllContentText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.appBlack54Color)),
            BlocBuilder<ChapterContentBloc, ChapterContentState>(
              builder: (context, state) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: width * 0.35,
                    height: media.height * 0.043,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), gradient: isEnglish ? const LinearGradient(colors: [Color(0xFF5B0D9A), Color(0xFFE180FF)]) : const LinearGradient(colors: [Color(0xFF5B0D9A), Color(0xFFE180FF)])),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(isEnglish ? "English" : "Hindi", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                        Switch(
                          // activeColor: Colors.white,
                          value: isEnglish,
                          onChanged: (value) {
                            context.read<ChapterContentBloc>().add(ToggleLanguageEvent());
                            setState(() {
                              isEnglish = !isEnglish;
                              language = isEnglish ? "English" : "Hindi";
                              print(language);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        SizedBox(height: media.height * 0.015),

        // TabBar
        TabBar(
          onTap: (index) {
            context.read<SubjectTabBloc>().add(SubjectChanged(index));
          },
          controller: _tabController,
          labelColor: Colors.purple,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.purple,
          indicatorWeight: 2.5,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: const TextStyle(fontWeight: FontWeight.w500),
          tabs: const [Tab(text: 'Videos'), Tab(text: 'Notes'), Tab(text: 'Test'), Tab(text: 'Quiz')],
        ),
        SizedBox(height: media.height * 0.015),

        // TabBarView for GridView content
        BlocListener<CategorySelectedBloc, CategorySelectedState>(
          listener: (context, state) {
            print(state.selectedCategory);
            // if (state.selectedCategory == "1") {
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => ClassesScreen(selectClassesName: AppString.animationText, id: "1")));
            // }
          },
          child: Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                BlocBuilder<ChapterContentBloc, ChapterContentState>(
                  builder: (context, state) {
                    print("video..list${state.chapters}");
                    print("video..list${state.isLoading}");
                    if (state.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Column(
                      children: [
                        state.chapters.isNotEmpty
                            ? Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.chapters.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  final item = state.chapters[index];
                                  final gradeLang = state.isEnglishSelected ? item.gradeLangEn : item.gradeLangHi;
                                  return ChapterItemCard(
                                    selectChapterName: widget.selectChapterName,
                                    item: item,
                                    onTap: () {
                                      context.read<ChapterContentBloc>().add(ChapterTapped(item!));
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => VideoContentDetailScreen(videoUrl: item.VideoUrl, language: language, selectChapterName: widget.selectChapterName, selectClassName: widget.selectClassesName, selectTopicName: '${state?.chapters[index].title}', descriptions: state?.chapters[index].subtitle ?? "Descriptions...")));
                                    },
                                    gradeLang: "${widget.selectClassesName} $language",
                                  );
                                },
                              ),
                            )
                            : Center(child: Text("No Record")),
                      ],
                    );
                  },
                ),
                // BlocBuilder<SubjectTabBloc, SubjectTabState>(
                //   builder: (context, state) {
                //     return AllContentListWidges(selectClassName: widget.selectClassesName, language: language, selectChaptorName: widget.selectChapterName);
                //   },
                // ),
                BlocBuilder<SubjectTabBloc, SubjectTabState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        SizedBox(height: media.height * 0.035),
                        CustomButton(
                          onPressed: () {
                            print("click notes");
                            Navigator.push(context, MaterialPageRoute(builder: (context) => NotesContentDetialScreen(selectClassName: widget.selectClassesName, tabtype: 'Notes', selectChapterName: widget.selectChapterName, language: widget.language, id: widget.id)));
                          },
                          text: "View Notes",
                          color: AppColors.buttonColorBlue1,
                          textColor: AppColors.appWhiteColor,
                        ),
                      ],
                    );
                  },
                ),
                BlocBuilder<SubjectTabBloc, SubjectTabState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        SizedBox(height: media.height * 0.035),
                        CustomButton(
                          onPressed: () {
                            print("click notes");
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TestContentDetialScreen(selectClassName: widget.selectClassesName, tabtype: 'Question Paper', selectChapterName: widget.selectChapterName, language: widget.language)));
                          },
                          text: "View Question Paper",
                          color: AppColors.buttonColorBlue1,
                          textColor: AppColors.appWhiteColor,
                        ),
                      ],
                    );
                  },
                ),
                BlocBuilder<SubjectTabBloc, SubjectTabState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Text(AppString.quetionForPracticeText),
                        SizedBox(height: media.height * 0.015),
                        CustomButton(
                          onPressed: () {
                            print("click notes");
                            Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen(selectClassesName: widget.selectClassesName, tabtype: 'Quiz', selectChapterName: widget.selectChapterName, language: widget.language)));
                          },
                          text: "Start Quiz",
                          color: AppColors.buttonColorBlue1,
                          textColor: AppColors.appWhiteColor,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
