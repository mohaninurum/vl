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
import 'package:visual_learning/screen/classes/bloc/classes_bloc.dart';
import 'package:visual_learning/screen/classes/bloc/classes_state.dart';
import 'package:visual_learning/screen/home_screen/blocs/CategorySelected/_category_selected_bloc.dart';
import 'package:visual_learning/screen/home_screen/blocs/CategorySelected/_category_selected_state.dart';

import '../../../constant/app_colors/app_colors.dart';
import '../../../constant/app_string/app_string.dart';
import '../../chapter/chapter_screen/chapter_screen.dart';
import '../../home_screen/blocs/CategorySelected/_category_selected_event.dart';
import '../../home_screen/widgets/banner_widget.dart';
import '../../home_screen/widgets/category_item_widget.dart';
import '../../widgets/appBarWidget.dart';
import '../bloc/classes_event.dart';

class ClassesScreen extends StatefulWidget {
  final String selectClassesName;
  final id;
  const ClassesScreen({required this.id, required this.selectClassesName, super.key});

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String language = 'English';
  bool isloading = true;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return; // Ignore during animation

      int selectedIndex = _tabController.index;
      String selectedTabLabel = selectedIndex == 0 ? 'English' : 'Hindi';
      language = selectedTabLabel;
      // 🟣 You can now call BLoC, setState, or print
      print("Selected tab: $selectedTabLabel");
      if (selectedTabLabel == "English") {
        print("tab english");
        context.read<ClassListBloc>().add(LoadClassList(id: widget.id, context: context));
      } else {
        context.read<ClassListBloc>().add(LoadClassList(id: widget.id, context: context));
      }
      // Example: Call BLoC Event
    });
    context.read<ClassListBloc>().add(LoadClassList(id: widget.id, context: context));
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
    final crossAxisCount = media.width > 600 ? 4 : 2;
    return Scaffold(
      appBar: AppBarWidget(),
      backgroundColor: const Color(0xFFF2F5FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: media.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: media.height * 0.01),
              BannerWidget(categoryName: widget.selectClassesName, screenName: "Classes"),
              SizedBox(height: media.height * 0.01),
              Text(AppString.chooseClassesText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.appBlack54Color)),
              SizedBox(height: media.height * 0.01),
              // TabBar
              TabBar(controller: _tabController, labelColor: Colors.purple, unselectedLabelColor: Colors.grey, indicatorColor: Colors.purple, indicatorWeight: 2.5, indicatorSize: TabBarIndicatorSize.tab, labelStyle: const TextStyle(fontWeight: FontWeight.w500), tabs: const [Tab(text: 'English'), Tab(text: 'Hindi')]),
              SizedBox(height: media.height * 0.015),

              // TabBarView for GridView content
              BlocListener<CategorySelectedBloc, CategorySelectedState>(
                listener: (context, state) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChapterScreen(selectClassName: state.selectedCategory, language: language, id: state.id)));
                },
                child: SizedBox(
                  height: media.height * 0.61, // Adjust based on your grid height
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      BlocBuilder<ClassListBloc, ClassListState>(
                        builder: (context, state) {
                          // if (state is InitailClassList) {
                          //   return Center(child: Text("Data Not Load"));
                          //   // return GridView.count(physics: const NeverScrollableScrollPhysics(), shrinkWrap: true, crossAxisCount: crossAxisCount, mainAxisSpacing: 16, crossAxisSpacing: 16, children: screenName == "home" ? gridItemHome : gridItemClasses);
                          // }

                          if (state is InitailClassList) {
                            return isloading ? SizedBox.shrink() : Center(child: CircularProgressIndicator());
                          }

                          if (state is LoadedClassList) {
                            isloading = false;
                            return state.classListResponse!.data.isNotEmpty
                                ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GridView.builder(
                                    itemCount: state.classListResponse?.data.length,
                                    shrinkWrap: true,
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: crossAxisCount, // number of columns
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 16,
                                      childAspectRatio: 1, // adjust height/width ratio
                                    ),
                                    itemBuilder: (context, index) {
                                      final item = state.classListResponse?.data[index];
                                      return CategoryItem(language: language, title: "${item?.className}", image: item?.classIcon ?? '', onTap: () => context.read<CategorySelectedBloc>().add(CategorySelected(id: item?.classId.toString() ?? '', category: "${item?.className}" ?? '')));
                                    },
                                  ),
                                )
                                : Center(child: Text("No Record"));
                          }
                          if (state is FailClassList) {
                            return Center(child: Text("Data Not Load"));
                          }
                          return SizedBox();
                        },
                      ),

                      BlocBuilder<ClassListBloc, ClassListState>(
                        builder: (context, state) {
                          // if (state is InitailClassList) {
                          //   return Center(child: Text("Data Not Load"));
                          //   // return GridView.count(physics: const NeverScrollableScrollPhysics(), shrinkWrap: true, crossAxisCount: crossAxisCount, mainAxisSpacing: 16, crossAxisSpacing: 16, children: screenName == "home" ? gridItemHome : gridItemClasses);
                          // }

                          if (state is InitailClassList) {
                            return isloading ? SizedBox.shrink() : Center(child: CircularProgressIndicator());
                          }

                          if (state is LoadedClassList) {
                            isloading = false;
                            return state.classListResponse!.data.isNotEmpty
                                ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GridView.builder(
                                    itemCount: state.classListResponse?.data.length,
                                    shrinkWrap: true,
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: crossAxisCount, // number of columns
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 16,
                                      childAspectRatio: 1, // adjust height/width ratio
                                    ),
                                    itemBuilder: (context, index) {
                                      final item = state.classListResponse?.data[index];
                                      return CategoryItem(language: language, title: "${item?.className}", image: item?.classIcon ?? '', onTap: () => context.read<CategorySelectedBloc>().add(CategorySelected(id: item?.classId.toString() ?? '', category: "${item?.className}" ?? '')));
                                    },
                                  ),
                                )
                                : Center(child: Text("No Record"));
                          }
                          if (state is FailClassList) {
                            return Center(child: Text("Data Not Load"));
                          }
                          return SizedBox();
                        },
                      ),
                      // GridviewListWidget(language: 'English', screenName: "Classes_English"), //
                      // GridviewListWidget(language: 'Hindi', screenName: "Classes_Hindi"), //
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
