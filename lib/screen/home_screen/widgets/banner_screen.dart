import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constant/app_colors/app_colors.dart';
import '../../../constant/app_text_colors/app_text_colors.dart';
import '../blocs/image_slider/image_slider_bloc.dart';
import '../blocs/image_slider/image_slider_event.dart';
import '../blocs/image_slider/image_slider_state.dart';

class AutoImageSliderWidget extends StatelessWidget {
  final List<String> imagePaths;
  final List<String> categoryName;
  final List<String> screenName;
  final List<Color> cardColor;
  const AutoImageSliderWidget({super.key, required this.imagePaths, required this.categoryName, required this.screenName, required this.cardColor});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return BlocProvider(
      create: (_) => ImageSliderBloc(itemCount: imagePaths.length),
      child: BlocBuilder<ImageSliderBloc, ImageSliderState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<ImageSliderBloc>(context);
          final image = imagePaths[state.currentIndex];
          final category = categoryName[state.currentIndex];
          final screen = screenName[state.currentIndex];

          return Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: cardColor[state.currentIndex]),
                padding: EdgeInsets.all(media.width * 0.04),
                child: Row(
                  children: [
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(category, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 20, fontWeight: FontWeight.w600)), screenName.isNotEmpty ? Text(screen, style: TextStyle(color: AppTextColors.appTextColorWhite, fontSize: 12, fontWeight: FontWeight.w600)) : const SizedBox.shrink()])),
                    const SizedBox(width: 10),
                    ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(image, height: media.height * 0.12, width: media.height * 0.12, fit: BoxFit.cover)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(imagePaths.length, (index) {
                  final isActive = index == state.currentIndex;
                  return GestureDetector(onTap: () => bloc.add(SelectImageEvent(index)), child: Container(margin: const EdgeInsets.symmetric(horizontal: 4), width: isActive ? 12 : 8, height: isActive ? 12 : 8, decoration: BoxDecoration(shape: BoxShape.circle, color: isActive ? AppColors.pramarycolor : Colors.grey.shade400)));
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
