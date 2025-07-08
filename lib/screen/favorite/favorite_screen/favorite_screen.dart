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
    getlan();
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

    return Scaffold(
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
                if (state.filteredFavorites.isEmpty) {
                  return const Center(child: Text("No favorites found"));
                }
                return ListView.builder(
                  itemCount: state.filteredFavorites.length,
                  itemBuilder: (context, index) {
                    return FavoriteItemCard(
                      onTap: () async {
                        print("hindi--url${state.filteredFavorites[index].videoUrlHindi ?? 'not url'}");
                        if (language == "English" && state.filteredFavorites[index].videoUrlEnglish != '') {
                          if (state.filteredFavorites[index].isPaid == "1") {
                            if (state.filteredFavorites[index].isPurchase == '1') {
                              SubscriptionDialog.show(context);
                            } else if (state.filteredFavorites[index].isPurchase == "2") {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => VideoFavoriteDetailScreen(screen: "Favorite Video", videoUrl: state.filteredFavorites[index].videoUrlEnglish.toString(), descriptions: state.filteredFavorites[index].subtitle, videoType: state.filteredFavorites[index].videoType)));
                            }
                          } else if (state.filteredFavorites[index].isPaid == "2") {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => VideoFavoriteDetailScreen(screen: "Favorite Video", videoUrl: state.filteredFavorites[index].videoUrlEnglish.toString(), descriptions: 'test', videoType: state.filteredFavorites[index].videoType)));
                          }
                        } else if (language == "English") {
                          InfoDialog.showHindiNotAvailable(context, "English");
                        }
                        if (language == "Hindi" && state.filteredFavorites[index].videoUrlHindi != '') {
                          if (state.filteredFavorites[index].isPaid == "1") {
                            if (state.filteredFavorites[index].isPurchase == '1') {
                              SubscriptionDialog.show(context);
                            } else if (state.filteredFavorites[index].isPurchase == "2") {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => VideoFavoriteDetailScreen(screen: "Favorite Video", videoUrl: state.filteredFavorites[index].videoUrlHindi.toString(), descriptions: state.filteredFavorites[index].subtitle, videoType: state.filteredFavorites[index].videoType)));
                            }
                          } else if (state.filteredFavorites[index].isPaid == "2") {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => VideoFavoriteDetailScreen(screen: "Favorite Video", videoUrl: state.filteredFavorites[index].videoUrlHindi.toString(), descriptions: state.filteredFavorites[index].subtitle, videoType: state.filteredFavorites[index].videoType)));
                          }
                        } else if (language == "Hindi") {
                          InfoDialog.showHindiNotAvailable(context, "Hindi");
                        }
                      },
                      item: state.filteredFavorites[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
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
