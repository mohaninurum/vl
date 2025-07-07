import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/all_content_bloc.dart';
import '../bloc/all_content_state.dart';
import 'chapter_content_card.dart';

class AllContentListWidges extends StatelessWidget {
  // List<ChapterContentModel> chapterAll;
  final String language;
  final String selectClassName;
  final String selectChaptorName;
  final String id;
  AllContentListWidges({super.key, required this.language, required this.selectClassName, required this.selectChaptorName, required this.id});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final availableHeight = media.size.height - media.padding.top - kToolbarHeight;
    return BlocBuilder<ChapterContentBloc, ChapterContentState>(
      builder: (context, state) {
        return Column(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: media.size.height * 0.65,
                child: ListView.builder(
                  itemCount: state.chapters.length,
                  itemBuilder: (context, index) {
                    final item = state.chapters[index];
                    final gradeLang = state.isEnglishSelected ? item.gradeLangEn : item.gradeLangHi;
                    return ChapterItemCard(
                      index: index,
                      item: item,
                      gradeLang: gradeLang,
                      onTap: () {
                        // context.read<ChapterContentBloc>().add(ChapterTapped(item));
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => VideoContentDetailScreen(videoUrl: "https://www.youtube.com/watch?v=nqye02H_H6I", language: gradeLang, selectChapterName: selectChaptorName, selectClassName: selectClassName, selectTopicName: item.title, descriptions: '')));
                      },
                    );
                  },
                ),

                // ListView.builder(
                //   shrinkWrap: true,
                //   itemCount: state?.chapters.length,
                //   scrollDirection: Axis.vertical,
                //   itemBuilder: (context, index) {
                //     final item = state?.chapters[index];
                //     return ChapterItemCard(
                //       item: item,
                //       onTap: () {
                //         print("on click chapter content");
                //         context.read<ChapterContentBloc>().chapters[index].bgColor = Colors.deepPurple;
                //         context.read<ChapterContentBloc>().add(ChapterTapped(item!));
                //         Navigator.push(context, MaterialPageRoute(builder: (context) => VideoContentDetailScreen(videoUrl: "https://www.youtube.com/watch?v=nqye02H_H6I", language: language, selectChapterName: selectChaptorName, selectClassName: selectClassName, selectTopicName: '${state?.chapters[index].title}')));
                //       },
                //     );
                //   },
                // ),
              ),
            ),
            SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
