import 'package:flutter/material.dart';
import 'package:visual_learning/constant/app_colors/app_colors.dart';

import '../../all_content/all_content_screen/all_content_screen.dart';
import '../model/chapter_list_model.dart';

class ChapterListWidget extends StatelessWidget {
  List<ChapterListModel> chapterAll;
  final String language;
  final String selectClassName;
  ChapterListWidget({required this.chapterAll, super.key, required this.language, required this.selectClassName});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: chapterAll.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AllContentScreen(language: language, selectClassName: selectClassName, selectChapterName: '${chapterAll[index].chapterTitle}')));
                  },
                  child: Container(color: AppColors.lightpurplecolor, child: ListTile(leading: Icon(Icons.play_circle_fill), title: Text("${index + 1}.${chapterAll[index].chapterTitle}", style: TextStyle(fontSize: 13)))),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
