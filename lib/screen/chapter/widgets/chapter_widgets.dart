// // // --- Classes Screen ---
// // class ClassesScreen extends StatelessWidget {
// //   String selectClassesName;
// //   ClassesScreen({required this.selectClassesName, super.key});
// //
// //   final List<BottomNavItemModel> navItems = [BottomNavItemModel(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'), BottomNavItemModel(icon: Icons.rss_feed_outlined, activeIcon: Icons.rss_feed, label: 'Feedback'), BottomNavItemModel(icon: Icons.phone_outlined, activeIcon: Icons.phone, label: 'Contact'), BottomNavItemModel(icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profile')];
// //   @override
// //   Widget build(BuildContext context) {
// //     final media = MediaQuery.of(context).size;
// //     return Scaffold(backgroundColor: const Color(0xFFF2F5FA), body: SafeArea(child: SingleChildScrollView(padding: EdgeInsets.symmetric(horizontal: media.width * 0.04, vertical: media.height * 0.02), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [SizedBox(height: media.height * 0.02), BannerWidget(categoryName: selectClassesName, screenName: "Classes"), SizedBox(height: media.height * 0.035), const Text(AppString.chooseClassesText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.appBlack54Color)), SizedBox(height: media.height * 0.025), GridviewListWidget(screenName: "Classes")]))), bottomNavigationBar: CustomBottomNavigation(items: navItems));
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:visual_learning/screen/home_screen/blocs/CategorySelected/_category_selected_bloc.dart';
// import 'package:visual_learning/screen/home_screen/blocs/CategorySelected/_category_selected_state.dart';
//
// import '../../../constant/app_colors/app_colors.dart';
// import '../../../constant/app_string/app_string.dart';
// import '../../../constant/app_text_colors/app_text_colors.dart';
// import '../../classes/classes_screen/classes_screen.dart';
// import '../blocs/chapter_bloc.dart';
// import '../blocs/chapter_event.dart';
// import '../blocs/chapter_state.dart';
// import '../blocs/subjecttab_bloc.dart';
// import '../blocs/subjecttab_event.dart';
// import '../blocs/subjecttab_state.dart';
// import '../model/chapter_list_model.dart';
// import 'chapter_list_widget.dart';
//
// class ChapterWidgets extends StatefulWidget {
//   final String selectClassesName;
//   final String language;
//   final String id;
//
//   const ChapterWidgets({required this.id, required this.language, required this.selectClassesName, super.key});
//
//   @override
//   State<ChapterWidgets> createState() => _ClassesScreenState();
// }
//
// class _ClassesScreenState extends State<ChapterWidgets> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   bool isload = false;
//   @override
//   void initState() {
//     _tabController = TabController(length: 3, vsync: this);
//     context.read<ChapterListBloc>().add(LoadChapterList(id: widget.id, context: context));
//     context.read<SubjectTabBloc>().add(SubjectChanged(0));
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   ChapterListState? oldState;
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final state = context.read<ChapterListBloc>().state;
//     if (state is LoadedChapterList && state != oldState) {
//       _tabController = TabController(length: state.classDetailResponse?.data.subjects.length ?? 0, vsync: this);
//       oldState = state;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final media = MediaQuery.of(context).size;
//     var indexget = widget.selectClassesName.indexOf('h');
//     List sub = ["Hindi", "English", "Math"];
//     return BlocBuilder<ChapterListBloc, ChapterListState>(
//       builder: (context, state) {
//         if (state is InitailChapterList) {
//           return Center(child: Text("No Record"));
//         }
//         if (state is IsLoadingChapterList) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (state is LoadedChapterList) {
//           _tabController = TabController(length: 3, vsync: this);
//           return SizedBox(
//             height: media.height,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: LinearGradient(colors: [AppColors.pramarycolor, AppColors.pramarycolor1], begin: Alignment.topLeft, end: Alignment.bottomRight)),
//                   padding: EdgeInsets.all(media.width * 0.04),
//                   child: Row(
//                     children: [
//                       Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(widget.selectClassesName, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 20, fontWeight: FontWeight.w600)), Text(AppString.animatedVideoText, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 10, fontWeight: FontWeight.w600)), Text(widget.language, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 9, fontWeight: FontWeight.w600))])),
//                       const SizedBox(width: 10),
//                       Image.asset('assets/appicons/icon5Asset 5.png', height: media.height * 0.12),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: media.height * 0.01),
//                 Text(AppString.chooseChapterText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.appBlack54Color)),
//                 SizedBox(height: media.height * 0.01),
//
//                 // TabBar
//                 TabBar(
//                   onTap: (index) {
//                     context.read<SubjectTabBloc>().add(SubjectChanged(index));
//                   },
//                   controller: _tabController,
//                   labelColor: Colors.purple,
//                   unselectedLabelColor: Colors.grey,
//                   indicatorColor: Colors.purple,
//                   indicatorWeight: 2.5,
//                   indicatorSize: TabBarIndicatorSize.tab,
//                   labelStyle: const TextStyle(fontWeight: FontWeight.w500),
//                   tabs: List.generate(3, (index) => Tab(text: sub[index])),
//                   //  [ListView.builder(itemCount: state.classDetailResponse?.data.subjects.length ?? 0, itemBuilder: (context, index) => Tab(text: "${state.classDetailResponse?.data.subjects[index]}"))],
//                   //[Tab(text: 'Hindi'), Tab(text: 'English'), Tab(text: 'Math')],
//                 ),
//                 SizedBox(height: media.height * 0.01),
//                 // TabBarView for GridView content
//                 BlocListener<CategorySelectedBloc, CategorySelectedState>(
//                   listener: (context, state) {
//                     print(state.selectedCategory);
//                     if (state.selectedCategory == "1") {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => ClassesScreen(selectClassesName: AppString.animationText, id: widget.id)));
//                     }
//                   },
//                   child: Expanded(
//                     child: TabBarView(
//                       controller: _tabController,
//                       children:
//                       // List.generate(state.classDetailResponse?.data.subjects.length ?? 1, (index) {
//                       //   final subject = state.classDetailResponse!.data.subjects[index];
//                       //   return ChapterListWidget(chapterAll: subject.chapters, language: widget.language, selectClassName: widget.selectClassesName.substring(0, indexget + 1));
//                       // }),
//                       [
//                         // ListView.builder(
//                         //   itemCount: state.classDetailResponse?.data.subjects.length,
//                         //   itemBuilder: (context, index) {
//                         //     return ChapterListWidget(chapterAll: state.classDetailResponse?.data.subjects[index].chapters ?? [], language: widget.language, selectClassName: widget.selectClassesName.substring(0, indexget + 1));
//                         //   },
//                         // ),
//                         BlocBuilder<SubjectTabBloc, SubjectTabState>(
//                           builder: (context, state) {
//                             return ChapterListWidget(chapterAll: [ChapterListModel("Motions"), ChapterListModel("Motions"), ChapterListModel("Motions"), ChapterListModel("Motions"), ChapterListModel("Motions"), ChapterListModel("Motions"), ChapterListModel("Motions"), ChapterListModel("Motions"), ChapterListModel("Motions"), ChapterListModel("Motions"), ChapterListModel("Motions"), ChapterListModel("Motions"), ChapterListModel("Force And Laws Of Motion"), ChapterListModel("Gravitation"), ChapterListModel("Work And Energy"), ChapterListModel("Sound")], language: widget.language, selectClassName: widget.selectClassesName.substring(0, indexget + 1));
//                           },
//                         ),
//                         BlocBuilder<SubjectTabBloc, SubjectTabState>(
//                           builder: (context, state) {
//                             return ChapterListWidget(chapterAll: state.chapters, language: widget.language, selectClassName: widget.selectClassesName.substring(0, indexget + 1));
//                           },
//                         ),
//                         BlocBuilder<SubjectTabBloc, SubjectTabState>(
//                           builder: (context, state) {
//                             return ChapterListWidget(chapterAll: state.chapters, language: widget.language, selectClassName: widget.selectClassesName.substring(0, indexget + 1));
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//         return Center(child: Text("No Record"));
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/screen/home_screen/blocs/CategorySelected/_category_selected_bloc.dart';
import 'package:visual_learning/screen/home_screen/blocs/CategorySelected/_category_selected_state.dart';

import '../../../constant/app_colors/app_colors.dart';
import '../../../constant/app_string/app_string.dart';
import '../../../constant/app_text_colors/app_text_colors.dart';
import '../blocs/chapter_bloc.dart';
import '../blocs/chapter_event.dart';
import '../blocs/chapter_state.dart';
import '../blocs/subjecttab_bloc.dart';
import '../blocs/subjecttab_event.dart';
import '../blocs/subjecttab_state.dart';
import 'chapter_list_widget.dart';

class ChapterWidgets extends StatefulWidget {
  final String selectClassesName;
  final String language;
  final String id;

  const ChapterWidgets({required this.id, required this.language, required this.selectClassesName, super.key});

  @override
  State<ChapterWidgets> createState() => _ChapterWidgetsState();
}

class _ChapterWidgetsState extends State<ChapterWidgets> with TickerProviderStateMixin {
  TabController? _tabController;
  ChapterListState? oldState;

  @override
  void initState() {
    super.initState();
    context.read<ChapterListBloc>().add(LoadChapterList(id: widget.id, context: context));
    context.read<SubjectTabBloc>().add(SubjectChanged(0));
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final indexget = widget.selectClassesName.indexOf('h');

    return BlocBuilder<ChapterListBloc, ChapterListState>(
      builder: (context, state) {
        if (state is InitailChapterList) {
          return const Center(child: Text("No Record"));
        }

        if (state is IsLoadingChapterList) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is LoadedChapterList) {
          final subjects = state.classDetailResponse?.data.subjects ?? [];

          if (_tabController == null || _tabController!.length != subjects.length) {
            _tabController = TabController(length: subjects.length, vsync: this);
          }

          return SizedBox(
            height: media.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                TabBar(tabAlignment: TabAlignment.start, isScrollable: true, onTap: (index) => context.read<SubjectTabBloc>().add(SubjectChanged(index)), controller: _tabController, labelColor: Colors.purple, unselectedLabelColor: Colors.grey, indicatorColor: Colors.purple, indicatorWeight: 2.5, indicatorSize: TabBarIndicatorSize.tab, labelStyle: const TextStyle(fontWeight: FontWeight.w500), tabs: List.generate(subjects.length, (index) => Tab(text: subjects[index].subjectName ?? 'Subject'))),
                SizedBox(height: media.height * 0.01),
                BlocListener<CategorySelectedBloc, CategorySelectedState>(
                  listener: (context, state) {
                    if (state.selectedCategory == "1") {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => ClassesScreen(selectClassesName: AppString.animationText, id: "9")));
                    }
                  },
                  child: Expanded(
                    child: TabBarView(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: _tabController,
                      children: List.generate(subjects.length, (index) {
                        return BlocBuilder<SubjectTabBloc, SubjectTabState>(
                          builder: (context, subState) {
                            return ChapterListWidget(
                              chapterAll: subjects[index].chapters ?? [],
                              language: widget.language, //
                              selectClassName: widget.selectClassesName.substring(0, indexget + 1),
                            );
                          },
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const Center(child: Text("No Record"));
      },
    );
  }
}
