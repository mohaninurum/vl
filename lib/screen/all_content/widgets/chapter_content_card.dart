import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/screen/all_content/bloc/all_content_event.dart';
import 'package:visual_learning/screen/all_content/model/all_content_model.dart';

import '../../../constant/app_colors/app_colors.dart';
import '../../auth/login_screen/blocs/login_bloc.dart';
import '../bloc/all_content_bloc.dart';
import '../bloc/all_content_state.dart';

class ChapterItemCard extends StatelessWidget {
  final ChapterContentModel? item;
  final VoidCallback onTap;
  final String gradeLang;
  final selectChapterName;
  final index;
  const ChapterItemCard({required this.item, required this.onTap, super.key, required this.gradeLang, this.selectChapterName, required this.index});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Container(
              width: width * 0.3,
              height: width * 0.2,
              decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12))),
              child: Padding(
                padding: const EdgeInsets.only(left: 7),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        "${item?.imageUrl}",
                        fit: BoxFit.fitWidth,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
                      ),
                      const Center(child: Icon(Icons.play_circle_fill, color: Colors.white, size: 32)),
                    ],
                  ),
                ),
              ),
            ),

            // Container(width: width * 0.3, height: width * 0.2, decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)), image: DecorationImage(image:  NetworkImage(item?.imageUrl ?? ''), fit: BoxFit.cover)), child: const Center(child: Icon(Icons.play_circle, color: Colors.white, size: 32))),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10, top: 4, left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start, //
                  //
                  children: [
                    Text(item?.title ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 4),
                    Text(
                      "Chapter:$selectChapterName" ?? '', //
                      style: const TextStyle(color: Colors.black87, fontSize: 12),
                    ),
                    const SizedBox(height: 5),
                    Padding(padding: const EdgeInsets.only(bottom: 5), child: Text(gradeLang, style: const TextStyle(color: Colors.black54, fontSize: 12))),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child:
                    item?.isPaid == "1"
                        ? item?.isPurchase == "2"
                            ? SizedBox()
                            : Icon(Icons.lock, color: Colors.redAccent.shade200)
                        : SizedBox(), //item?.isPaid == "1"
                // : item?.isPurchase == "2"
                // ? Icon(Icons.lock_open, color: Colors.green)
                // : SizedBox(),
              ),
            ),

            BlocBuilder<ChapterContentBloc, ChapterContentState>(
              builder: (context, state) {
                final item = state.chapters[index]; // Always use latest state
                final isFavorited = item.isFavorited ?? false;

                return InkWell(
                  onTap: () {
                    final login = BlocProvider.of<LoginBloc>(context).loginResponse?.user;
                    final token = login?.token ?? '';
                    final userId = login?.userId.toString() ?? '';
                    final videoId = item.videoId;

                    context.read<ChapterContentBloc>().add(FavoriteEvent(languageType: gradeLang, token: token, userID: userId, context: context, selectIndex: index, favoriteID: videoId, isfavorite: !isFavorited));
                  },
                  child: CircleAvatar(radius: width * 0.06, backgroundColor: Colors.purple.shade50, child: Icon(isFavorited ? Icons.favorite : Icons.favorite_border_outlined, size: 30, color: AppColors.pramarycolor)),
                );
              },
            ),

            // BlocBuilder<ChapterContentBloc, ChapterContentState>(
            //   builder: (context, state) {
            //     final isFavorited = item?.isFavorited == "true" ? true : state.favoriteIndexes.contains(index);
            //     return InkWell(
            //       onTap: () {
            //         var token = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.token.toString() ?? '';
            //         var id = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.userId.toString() ?? '';
            //         context.read<ChapterContentBloc>().add(FavoriteEvent(token: token, userID: id, context: context, selectIndex: index, favoriteID: item?.videoId ?? '', isfavorite: !isFavorited));
            //       },
            //       child: CircleAvatar(radius: width * 0.06, backgroundColor: Colors.purple.shade50, child: Icon(isFavorited ? Icons.favorite : Icons.favorite_border_outlined, size: 30, color: AppColors.pramarycolor)),
            //       // Icon(isFavorited ? Icons.favorite : Icons.favorite_border_outlined, size: 30, color: AppColors.pramarycolor),
            //     );
            //   },
            // ),
            SizedBox(width: 5),

            // BlocBuilder<ChapterContentBloc, ChapterContentState>(
            //   builder: (context, state) {
            //     return InkWell(
            //       onTap: () {
            //         context.read<ChapterContentBloc>().add(FavoriteEvent(selectIndex: index, favoriteID: "", isfavorite: true));
            //       },
            //       child: Icon(index == state.selectIndex && state.isFavorite ? Icons.favorite : Icons.favorite_border_outlined, size: 45, color: AppColors.pramarycolor),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

// class ChapterItemCard extends StatelessWidget {
//   final ChapterContentModel? item;
//   final VoidCallback onTap;
//   final String gradeLang; // NEW: Injected from parent widget
//
//   const ChapterItemCard({required this.item, required this.onTap, required this.gradeLang, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
//         decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
//         child: Row(
//           children: [
//             Container(
//               width: width * 0.3,
//               height: width * 0.2,
//               decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12))),
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
//                 child: Stack(
//                   fit: StackFit.expand,
//                   children: [
//                     Image.network(
//                       item?.imageUrl ?? '',
//                       fit: BoxFit.cover,
//                       loadingBuilder: (context, child, loadingProgress) {
//                         if (loadingProgress == null) return child;
//                         return const Center(child: CircularProgressIndicator());
//                       },
//                       errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
//                     ),
//                     const Center(child: Icon(Icons.play_circle_fill, color: Colors.white, size: 32)),
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(item?.title ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                     const SizedBox(height: 4),
//                     Text(item?.subtitle ?? '', style: const TextStyle(color: Colors.black87, fontSize: 13)),
//                     const SizedBox(height: 4),
//                     Text(gradeLang, style: const TextStyle(color: Colors.black54, fontSize: 12)), // UPDATED
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
