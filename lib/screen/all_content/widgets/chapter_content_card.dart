import 'package:flutter/material.dart';
import 'package:visual_learning/screen/all_content/model/all_content_model.dart';

class ChapterItemCard extends StatelessWidget {
  final ChapterContentModel? item;
  final VoidCallback onTap;
  final String gradeLang;
  final selectChapterName;
  const ChapterItemCard({required this.item, required this.onTap, super.key, required this.gradeLang, this.selectChapterName});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Container(
              width: width * 0.3,
              height: width * 0.2,
              decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12))),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      "${item?.imageUrl}",
                      fit: BoxFit.cover,
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

            // Container(width: width * 0.3, height: width * 0.2, decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)), image: DecorationImage(image:  NetworkImage(item?.imageUrl ?? ''), fit: BoxFit.cover)), child: const Center(child: Icon(Icons.play_circle, color: Colors.white, size: 32))),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start, //
                  //
                  children: [
                    Text(item?.title ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(
                      "Chapter:$selectChapterName" ?? '', //
                      style: const TextStyle(color: Colors.black87, fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Text(gradeLang, style: const TextStyle(color: Colors.black54, fontSize: 12)),
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
