import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/constant/app_string/app_string.dart';
import 'package:visual_learning/screen/home_screen/blocs/category/category_state.dart';

import '../blocs/CategorySelected/_category_selected_bloc.dart';
import '../blocs/CategorySelected/_category_selected_event.dart';
import '../blocs/category/category_bloc.dart';
import 'category_item_widget.dart';

class GridviewListWidget extends StatelessWidget {
  var screenName;
  String language;
  GridviewListWidget({required this.language, this.screenName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var gridItemHome = [CategoryItem(language: '', title: AppString.animationText, image: 'assets/appicons/3d animattion.png', onTap: () => context.read<CategorySelectedBloc>().add(CategorySelected('1'))), CategoryItem(language: '', title: 'My Teachers', image: 'assets/appicons/icon12Asset 12.png', comingSoon: true, onTap: () {}), CategoryItem(language: '', title: 'Notes', image: 'assets/appicons/digital notesAsset 1.png', onTap: () => context.read<CategorySelectedBloc>().add(CategorySelected('3'))), CategoryItem(language: '', title: 'Test Paper', image: 'assets/appicons/icon23Asset 1.png', onTap: () => context.read<CategorySelectedBloc>().add(CategorySelected('4')))];
    var gridItemClasses = [CategoryItem(language: language, title: '9th Class', image: 'assets/appicons/3d animattion.png', onTap: () => context.read<CategorySelectedBloc>().add(CategorySelected('9th Class'))), CategoryItem(language: language, title: '10th Class', image: 'assets/appicons/icon12Asset 12.png', comingSoon: true, onTap: () {}), CategoryItem(language: language, title: '11th Class', image: 'assets/appicons/digital notesAsset 1.png', onTap: () => context.read<CategorySelectedBloc>().add(CategorySelected('11th Class'))), CategoryItem(language: language, title: '12th Class', image: 'assets/appicons/digital notesAsset 1.png', onTap: () => context.read<CategorySelectedBloc>().add(CategorySelected('12th Class')))];
    final media = MediaQuery.of(context).size;
    final crossAxisCount = media.width > 600 ? 4 : 2;
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryInitial) {
          return Center(child: Text("Data Not Load"));
          // return GridView.count(physics: const NeverScrollableScrollPhysics(), shrinkWrap: true, crossAxisCount: crossAxisCount, mainAxisSpacing: 16, crossAxisSpacing: 16, children: screenName == "home" ? gridItemHome : gridItemClasses);
        }
        if (state is IsLoadingCategory) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is LoadedCategoryState) {
          return state.categoryResponseModel.categories.isNotEmpty
              ? GridView.builder(
                itemCount: state.categoryResponseModel.categories.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount, // number of columns
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1, // adjust height/width ratio
                ),
                itemBuilder: (context, index) {
                  final item = state.categoryResponseModel.categories[index];
                  return CategoryItem(language: language, title: item.categoryName, image: item.categoryIcon, onTap: () => context.read<CategorySelectedBloc>().add(CategorySelected(item.categoryName)));
                },
              )
              : Center(child: Text("No Record"));
        }
        if (state is FialdCategoryState) {
          return Center(child: Text("Data Not Load"));
        }
        return SizedBox();
      },
    );
  }
}
