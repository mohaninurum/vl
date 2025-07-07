// widgets/favorite_item_card.dart
import 'package:flutter/material.dart';

import '../models/models.dart';

class FavoriteItemCard extends StatelessWidget {
  final FavoriteItem item;
  final VoidCallback onTap;
  const FavoriteItemCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.grey.shade200, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: const Offset(0, 2))]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              // Thumbnail
              SizedBox(width: width * 0.02),
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
                        "${item?.thumbnailUrl}",
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
              // Stack(children: [ClipRRect(borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)), child: Image.network(item.thumbnailUrl, width: width * 0.30, height: width * 0.18, fit: BoxFit.fitWidth)), Align(alignment: Alignment.center, child: Positioned(child: Icon(Icons.play_circle_fill, color: Colors.white, size: 32)))]),
              SizedBox(width: width * 0.04),
              // Title & Subtitle
              Expanded(child: Padding(padding: EdgeInsets.symmetric(vertical: width * 0.020), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(item.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: width * 0.040, fontWeight: FontWeight.w600, color: Colors.black87)), const SizedBox(height: 4), Text(item.subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: width * 0.030, color: Colors.grey[700]))]))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child:
                      item.isPaid == "1"
                          ? item.isPurchase == "2"
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
      ),
    );
  }
}
