import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visual_learning/screen/search_screen/search_screen/pdf_view_widgets.dart';
import 'package:visual_learning/screen/search_screen/search_screen/search_widgets.dart';
import 'package:visual_learning/screen/search_screen/search_screen/title_divider.dart';
import 'package:visual_learning/screen/widgets/appBarWidget.dart';

import '../../../constant/widgets/subscription_dialog.dart';
import '../../all_content/widgets/video_avalable_info_diallog.dart';
import '../../auth/login_screen/blocs/login_bloc.dart';
import '../../favorite/widgets/video_playe_screen.dart';
import '../blocs/search_bloc.dart';
import '../blocs/search_event.dart';
import '../blocs/search_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? language = '';

  @override
  void initState() {
    var token = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.token.toString() ?? '';
    getlan();
    context.read<SearchBloc>().add(PerformSearch(query: '', token: token));
    super.initState();
  }

  getlan() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    language = prefs.getString('language') ?? '';
    print("Lang---get$language");
  }

  @override
  Widget build(BuildContext context) {
    final isPurchase = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.isSubscribe.toString();
    return Scaffold(
      appBar: AppBarWidget(appTitle: "Search"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.all(8.0), child: SearchBarWithButton()),
            Padding(
              padding: const EdgeInsets.all(12),
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is ContentLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ContentLoaded) {
                    final screenWidth = MediaQuery.of(context).size.width;
                    if (state.videos.isEmpty && state.videos.isEmpty && state.videos.isEmpty) {
                      return Column(children: [Center(child: Text("No Record"))]);
                    }
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SearchBarWithButton(), SizedBox(height: 20),
                          // Videos
                          Offstage(
                            offstage: state.videos.isEmpty,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: const EdgeInsets.only(bottom: 10), child: TitleDivider(title: "video", Iconstype: Icon(Icons.video_collection, color: Colors.white))),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: screenWidth * 0.35,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.videos.length,
                                    itemBuilder: (context, index) {
                                      final video = state.videos[index];
                                      return InkWell(
                                        onTap: () async {
                                          if (language == "English" && video.videoUrlEnglish != '') {
                                            if (video.isPaid.toString() == "1") {
                                              if (isPurchase == '1') {
                                                SubscriptionDialog.show(context);
                                              } else if (isPurchase == "2") {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => VideoFavoriteDetailScreen(screen: "Video", videoUrl: video.videoUrlEnglish.toString(), descriptions: video.title, videoType: video.videoType.toString())));
                                              }
                                            } else if (video.isPaid.toString() == "2") {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => VideoFavoriteDetailScreen(screen: "Video", videoUrl: video.videoUrlEnglish.toString(), descriptions: video.title, videoType: video.videoType.toString())));
                                            }
                                          } else if (language == "English") {
                                            InfoDialog.showHindiNotAvailable(context, "English");
                                          }
                                          if (language == "Hindi" && video.videoUrlHindi != '') {
                                            if (video.isPaid.toString() == "1") {
                                              if (isPurchase == '1') {
                                                SubscriptionDialog.show(context);
                                              } else if (isPurchase == "2") {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => VideoFavoriteDetailScreen(screen: "Video", videoUrl: video.videoUrlHindi.toString(), descriptions: video.title, videoType: video.videoType.toString())));
                                              }
                                            } else if (video.isPaid.toString() == "2") {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => VideoFavoriteDetailScreen(screen: "Video", videoUrl: video.videoUrlHindi.toString(), descriptions: video.title, videoType: video.videoType.toString())));
                                            }
                                          } else if (language == "Hindi") {
                                            InfoDialog.showHindiNotAvailable(context, "Hindi");
                                          }
                                        },

                                        child: Container(
                                          width: screenWidth * 0.5,
                                          margin: const EdgeInsets.only(right: 12),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(12),
                                                child: Container(
                                                  height: screenWidth * 0.25,
                                                  decoration: BoxDecoration(color: Colors.blue.shade200, borderRadius: BorderRadius.circular(10)),
                                                  child: Stack(
                                                    fit: StackFit.expand,
                                                    children: [
                                                      Image.network(
                                                        video.thumbnailUrl,
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
                                              const SizedBox(height: 4),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(video.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                                                  Align(
                                                    alignment: Alignment.bottomRight,
                                                    child:
                                                        video.isPaid.toString() == "1"
                                                            ? isPurchase == "2"
                                                                ? SizedBox()
                                                                : Icon(Icons.lock, color: Colors.redAccent.shade200)
                                                            : SizedBox(), //item?.isPaid == "1"
                                                    // : item?.isPurchase == "2"
                                                    // ? Icon(Icons.lock_open, color: Colors.green)
                                                    // : SizedBox(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Notes
                          Offstage(
                            offstage: state.notes.isEmpty,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: const EdgeInsets.only(bottom: 10), child: TitleDivider(title: "Notes", Iconstype: Icon(Icons.note, color: Colors.white))),

                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 80,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.notes.length,
                                    itemBuilder: (context, index) {
                                      final note = state.notes[index];
                                      return InkWell(
                                        onTap: () async {
                                          if (note.isPaid.toString() == "1") {
                                            if (isPurchase == '1') {
                                              SubscriptionDialog.show(context);
                                            } else if (isPurchase == "2") {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => PdfViewWidgets(pdgUrl: note.pdfUrl)));
                                            }
                                          } else if (note.isPaid.toString() == "2") {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => PdfViewWidgets(pdgUrl: note.pdfUrl)));
                                          }
                                        },
                                        child: Container(
                                          width: screenWidth * 0.4,
                                          margin: const EdgeInsets.only(right: 12),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(8)),
                                          child: Column(
                                            mainAxisAlignment: note.isPaid.toString() == "1" ? MainAxisAlignment.start : MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Align(
                                                    alignment: Alignment.topRight,
                                                    child:
                                                        note.isPaid.toString() == "1"
                                                            ? isPurchase == "2"
                                                                ? SizedBox()
                                                                : Icon(Icons.lock, color: Colors.redAccent.shade200)
                                                            : SizedBox(), //item?.isPaid == "1"
                                                    // : item?.isPurchase == "2"
                                                    // ? Icon(Icons.lock_open, color: Colors.green)
                                                    // : SizedBox(),
                                                  ),
                                                ],
                                              ),
                                              Row(children: [const Icon(Icons.note, color: Colors.orange), const SizedBox(width: 10), Expanded(child: Text(note.title, maxLines: 1, overflow: TextOverflow.ellipsis))]),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          // PDFs
                          Offstage(
                            offstage: state.pdfs.isEmpty,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: const EdgeInsets.only(bottom: 10), child: TitleDivider(title: "PDFs", Iconstype: Icon(Icons.picture_as_pdf, color: Colors.white))),

                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 80,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.pdfs.length,
                                    itemBuilder: (context, index) {
                                      final pdf = state.pdfs[index];
                                      return InkWell(
                                        onTap: () async {
                                          if (pdf.isPaid.toString() == "1") {
                                            if (isPurchase == '1') {
                                              SubscriptionDialog.show(context);
                                            } else if (isPurchase == "2") {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => PdfViewWidgets(pdgUrl: pdf.pdfUrl)));
                                            }
                                          } else if (pdf.isPaid.toString() == "2") {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => PdfViewWidgets(pdgUrl: pdf.pdfUrl)));
                                          }
                                        },
                                        child: Container(
                                          width: screenWidth * 0.4,
                                          margin: const EdgeInsets.only(right: 12),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(color: Colors.purple.shade100, borderRadius: BorderRadius.circular(8)),
                                          child: Column(
                                            mainAxisAlignment: pdf.isPaid.toString() == "1" ? MainAxisAlignment.start : MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Align(
                                                    alignment: Alignment.topRight,
                                                    child:
                                                        pdf.isPaid.toString() == "1"
                                                            ? isPurchase == "2"
                                                                ? SizedBox()
                                                                : Icon(Icons.lock, color: Colors.redAccent.shade200, size: 17)
                                                            : SizedBox(), //item?.isPaid == "1"
                                                    // : item?.isPurchase == "2"
                                                    // ? Icon(Icons.lock_open, color: Colors.green)
                                                    // : SizedBox(),
                                                  ),
                                                ],
                                              ),
                                              Row(children: [const Icon(Icons.picture_as_pdf, color: Colors.purple), const SizedBox(width: 10), Expanded(child: Text(pdf.title, maxLines: 1, overflow: TextOverflow.ellipsis))]),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  {
                    return const Center(child: Text("Something went wrong"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
