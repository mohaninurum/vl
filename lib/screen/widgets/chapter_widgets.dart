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
import 'package:visual_learning/screen/home_screen/blocs/CategorySelected/_category_selected_bloc.dart';
import 'package:visual_learning/screen/home_screen/blocs/CategorySelected/_category_selected_state.dart';

import '../../constant/app_colors/app_colors.dart';
import '../../constant/app_string/app_string.dart';
import '../../constant/app_text_colors/app_text_colors.dart';
import '../chapter/blocs/subjecttab_bloc.dart';
import '../chapter/blocs/subjecttab_event.dart';
import '../chapter/blocs/subjecttab_state.dart';
import '../chapter/widgets/chapter_list_widget.dart';
import '../classes/classes_screen/classes_screen.dart';

class ChapterWidgets extends StatefulWidget {
  final String selectClassesName;
  final String language;

  const ChapterWidgets({required this.language, required this.selectClassesName, super.key});

  @override
  State<ChapterWidgets> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ChapterWidgets> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    context.read<SubjectTabBloc>().add(SubjectChanged(0));
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    var indexget = widget.selectClassesName.indexOf('h');

    return SizedBox(
      height: media.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: LinearGradient(colors: [AppColors.pramarycolor, AppColors.pramarycolor1], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            padding: EdgeInsets.all(media.width * 0.04),
            child: Row(
              children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(widget.selectClassesName, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 20, fontWeight: FontWeight.w600)), Text(AppString.animatedVideoText, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 10, fontWeight: FontWeight.w600)), Text(widget.language, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 9, fontWeight: FontWeight.w600))])),
                const SizedBox(width: 10),
                Image.asset('assets/appicons/icon5Asset 5.png', height: media.height * 0.12),
              ],
            ),
          ),
          SizedBox(height: media.height * 0.01),
          Text(AppString.chooseChapterText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.appBlack54Color)),
          SizedBox(height: media.height * 0.01),

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
            tabs: const [Tab(text: 'Physics'), Tab(text: 'Chemistry'), Tab(text: 'Biology')],
          ),
          SizedBox(height: media.height * 0.01),

          // TabBarView for GridView content
          BlocListener<CategorySelectedBloc, CategorySelectedState>(
            listener: (context, state) {
              print(state.selectedCategory);
              if (state.selectedCategory == "1") {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ClassesScreen(selectClassesName: AppString.animationText)));
              }
            },
            child: Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  BlocBuilder<SubjectTabBloc, SubjectTabState>(
                    builder: (context, state) {
                      return ChapterListWidget(chapterAll: state.chapters, language: widget.language, selectClassName: widget.selectClassesName.substring(0, indexget + 1));
                    },
                  ),
                  BlocBuilder<SubjectTabBloc, SubjectTabState>(
                    builder: (context, state) {
                      return ChapterListWidget(chapterAll: state.chapters, language: widget.language, selectClassName: widget.selectClassesName.substring(0, indexget + 1));
                    },
                  ),
                  BlocBuilder<SubjectTabBloc, SubjectTabState>(
                    builder: (context, state) {
                      return ChapterListWidget(chapterAll: state.chapters, language: widget.language, selectClassName: widget.selectClassesName.substring(0, indexget + 1));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
