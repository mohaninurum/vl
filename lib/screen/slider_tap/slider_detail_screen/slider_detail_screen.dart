// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
//
// import '../../home_screen/model/banner_slider.dart';
// import '../../widgets/appBarWidget.dart';
//
// class SliderDetailScreen extends StatefulWidget {
//   List<BannerData>? banners;
//   int index;
//   SliderDetailScreen({required this.index, this.banners, super.key});
//
//   @override
//   State<SliderDetailScreen> createState() => _SliderDetailScreenState();
// }
//
// class _SliderDetailScreenState extends State<SliderDetailScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarWidget(appTitle: "Detail"),
//       body: Column(
//         //
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Center(
//             child: Hero(
//               //
//               tag: '${widget.index}', //
//               child: CachedNetworkImage(fit: BoxFit.cover, width: double.infinity, height: double.infinity, imageUrl: widget.banners[widget.index].image, placeholder: (context, url) => Center(child: CircularProgressIndicator()), errorWidget: (context, url, error) => Icon(Icons.error)),
//               // FadeInImage(
//               //   height: 200,
//               //   fit: BoxFit.fill, //
//               //   placeholder: AssetImage('assets/images/images.png'),
//               //   image: NetworkImage("${widget.banners?[widget.index].image}"),
//               // ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
