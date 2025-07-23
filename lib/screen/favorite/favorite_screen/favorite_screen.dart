// screens/favorite_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/widgets/subscription_dialog.dart';
import '../../all_content/widgets/video_avalable_info_diallog.dart';
import '../../auth/login_screen/blocs/login_bloc.dart';
import '../../widgets/appBarWidget.dart';
import '../blocs/favorite_bloc.dart';
import '../blocs/favorite_event.dart';
import '../blocs/favorite_state.dart';
import '../widgets/button_widgets.dart';
import '../widgets/item_card.dart';
import '../widgets/video_playe_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  String? language = '';
  @override
  void initState() {
    // getlan();
    var token = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.token.toString() ?? '';
    var id = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.userId.toString() ?? '';
    context.read<FavoriteBloc>().add(LoadFavorites(userID: id, token: token, context: context));
    super.initState();
  }

  getlan() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    language = prefs.getString('language') ?? '';
    print("Lang---get$language");
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final isPurchase = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.isSubscribe.toString();
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(appTitle: 'Favorites'),
        body: Column(
          children: [
            //
            Container(decoration: BoxDecoration(color: Colors.deepPurple.shade100, boxShadow: [BoxShadow(color: Colors.black, blurRadius: 4.0)]), child: _CategoryTabs(width: width)),
            Expanded(
              child: BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.allFavorites.isEmpty) {
                    return const Center(child: Text("No favorites found"));
                  }
                  return ListView.builder(
                    itemCount: state.allFavorites.length,
                    itemBuilder: (context, index) {
                      if (state.allFavorites[index].languageType == 1) {
                        language = "Hindi";
                      } else {
                        language = "English";
                      }

                      return FavoriteItemCard(
                        language: language ?? '',
                        onTap: () async {
                          print("Check language--$language");
                          if (state.allFavorites[index].languageType.toString() == "2" && state.allFavorites[index].videoUrlEnglish != '') {
                            if (state.allFavorites[index].isPaid.toString() == "1") {
                              if (isPurchase.toString() == '1') {
                                SubscriptionDialog.show(context);
                              } else if (isPurchase.toString() == "2") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => VideoFavoriteDetailScreen(screen: "Favorite Video", videoUrl: state.allFavorites[index].videoUrlEnglish.toString(), descriptions: state.allFavorites[index].description ?? '', videoType: state.allFavorites[index].videoType.toString())));
                              }
                            } else if (state.allFavorites[index].isPaid.toString() == "2") {
                              //   Navigator.push(context, MaterialPageRoute(builder: (context) => QVideoPlayer()));
                              Navigator.push(context, MaterialPageRoute(builder: (context) => VideoFavoriteDetailScreen(screen: "Favorite Video", videoUrl: state.allFavorites[index].videoUrlEnglish.toString(), descriptions: 'test', videoType: state.allFavorites[index].videoType.toString())));
                            }
                          } else if (state.allFavorites[index].languageType.toString() == "1" && state.allFavorites[index].videoUrlHindi != '') {
                            if (state.allFavorites[index].isPaid.toString() == "1") {
                              if (isPurchase.toString() == '1') {
                                SubscriptionDialog.show(context);
                              } else if (isPurchase.toString() == "2") {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => VideoFavoriteDetailScreen(screen: "Favorite Video", videoUrl: state.allFavorites[index].videoUrlHindi.toString(), descriptions: state.allFavorites[index].description ?? "", videoType: state.allFavorites[index].videoType.toString())));
                              }
                            } else if (state.allFavorites[index].isPaid.toString() == "2") {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => VideoFavoriteDetailScreen(screen: "Favorite Video", videoUrl: state.allFavorites[index].videoUrlHindi.toString(), descriptions: state.allFavorites[index].description ?? '', videoType: state.allFavorites[index].videoType.toString())));
                            }
                          } else if (state.allFavorites[index].languageType.toString() == "2") {
                            InfoDialog.showHindiNotAvailable(context, "English");
                          } else if (state.allFavorites[index].languageType.toString() == "1") {
                            InfoDialog.showHindiNotAvailable(context, "Hindi");
                          }
                        },
                        item: state.allFavorites[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryTabs extends StatelessWidget {
  final double width;
  const _CategoryTabs({required this.width});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: width * 0.04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                FavoriteCategory.values.map((cat) {
                  final isSelected = state.selectedCategory == cat;
                  return GestureDetector(
                    onTap: () => context.read<FavoriteBloc>().add(ChangeCategory(category: cat)), //Video, Test, Notes
                    child: TypeButton(icon: Icon(Icons.video_collection), isSelected: isSelected, type: cat.name),
                    //Container(padding: EdgeInsets.symmetric(vertical: width * 0.02, horizontal: width * 0.05), decoration: BoxDecoration(color: isSelected ? Colors.blue : Colors.grey.shade300, borderRadius: BorderRadius.circular(20)), child: Text(cat.name, style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontSize: width * 0.04))),
                  );
                }).toList(),
          ),
        );
      },
    );
  }
}
