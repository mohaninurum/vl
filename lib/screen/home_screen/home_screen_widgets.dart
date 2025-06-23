import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/screen/home_screen/widgets/GridView_list_widget.dart';
import 'package:visual_learning/screen/home_screen/widgets/banner_slider.dart';
import 'package:visual_learning/screen/home_screen/widgets/search_bar.dart';

import '../../constant/app_colors/app_colors.dart';
import '../../constant/app_string/app_string.dart';
import '../classes/classes_screen/classes_screen.dart';
import '../drawer/drawer_screen.dart';
import '../notes/notes_screen/notes_screen.dart';
import '../quiz_screen/quiz_main_screen.dart';
import '../test_paper/test_paper_screen/test_paper_screen.dart';
import 'blocs/CategorySelected/_category_selected_bloc.dart';
import 'blocs/CategorySelected/_category_selected_state.dart';

class HomeScreenWidget extends StatelessWidget {
  HomeScreenWidget({super.key});
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _titleWidget(Size media) {
    return InkWell(
      onTap: () {
        scaffoldKey.currentState?.openDrawer();
      },
      child: Padding(
        padding: EdgeInsets.only(top: media.height * 0.01),
        child: Container(
          padding: EdgeInsets.all(5.5),
          decoration: BoxDecoration(color: AppColors.pramarycolor, borderRadius: BorderRadius.circular(10)),

          child: Icon(Icons.menu, color: AppColors.appWhiteColor),
          // SvgPicture.asset(AppImages.menu, color: AppColor.blue200)
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: AppDrawer(),
        backgroundColor: const Color(0xFFF2F5FA),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _titleWidget(media),
                    Image.asset('assets/appicons/Visuallearning trans.png', height: media.height * 0.07),
                    SizedBox(width: media.width * 0.01),
                    Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [const Text(AppString.welcomeToText, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.appBlack54Color)), const Text(AppString.visualLearningText, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.pramarycolor))]),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        showSearch(
                          context: context,

                          // Delegate to customize the search bar
                          delegate: CustomSearchDelegate(),
                        );
                      },
                      child: Container(padding: EdgeInsets.only(top: media.height * 0.01, left: media.width * 0.012, right: media.width * 0.01, bottom: media.height * 0.01), decoration: BoxDecoration(color: AppColors.pramarycolor, shape: BoxShape.circle), child: Icon(Icons.search, color: Colors.white)),
                    ),

                    Spacer(),
                    Icon(Icons.circle_notifications, size: 40, color: AppColors.pramarycolor), //  Badge(smallSize: 20, label: Text('1'), child: IconButton(padding: EdgeInsets.zero, onPressed: () {}, icon: Icon(Icons.circle_notifications), iconSize: 50)),
                  ],
                ),
                SizedBox(height: media.height * 0.02),
                // BannerWidget(categoryName: AppString.bannerLeartTodayText, screenName: ''),
                // AutoImageSliderWidget(imagePaths: ['assets/appicons/digital notesAsset 1.png', 'assets/appicons/icon4Asset 4.png', 'assets/appicons/animationAsset 2.png'], categoryName: ["Learn Today", "video learn", "subscriptions"], screenName: ["video", "all notes", "subscription"], cardColor: [Colors.brown, Colors.blueGrey, Colors.deepPurpleAccent.shade200]),
                AdvancedAutoBannerSlider(),
                SizedBox(height: media.height * 0.035),
                Text(AppString.exploreCategoriesText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.appBlack54Color)),
                SizedBox(height: media.height * 0.025),
                BlocListener<CategorySelectedBloc, CategorySelectedState>(
                  listener: (context, state) {
                    print(state.selectedCategory);
                    if (state.selectedCategory == "video") {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ClassesScreen(selectClassesName: state.selectedCategory, id: "1")));
                    }
                    if (state.selectedCategory == "notes") {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NotesScreen(selectsName: "Notes")));
                    }
                    if (state.selectedCategory == "test paper") {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TestPaperScreen(selectsName: "Test Paper")));
                    }
                    if (state.selectedCategory == "quiz") {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => QuizMainScreen()));
                    }
                    if (state.selectedCategory == "Animation") {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => QuizMainScreen()));
                    }
                  },
                  child: GridviewListWidget(screenName: "home", language: ''),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
