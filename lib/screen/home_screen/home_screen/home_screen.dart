import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/screen/home_screen/blocs/category/category_bloc.dart';
import 'package:visual_learning/screen/home_screen/blocs/category/category_event.dart';

import '../../../constant/app_colors/app_colors.dart';
import '../blocs/BottomNav/bottom_nav_bloc.dart';
import '../blocs/BottomNav/bottom_nav_state.dart';
import '../home_screen_widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<HomeScreen> {
  // Global keys for nested navigation
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [GlobalKey<NavigatorState>(), GlobalKey<NavigatorState>(), GlobalKey<NavigatorState>(), GlobalKey<NavigatorState>()];

  void _onTabTapped(int index, String tabName) {
    final bloc = context.read<BottomNavBloc>();
    if (bloc.currentIndex == index) {
      // If same tab is tapped, pop to first route

      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    }
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.pramarycolor, // Set your desired color
        statusBarIconBrightness: Brightness.light, // For dark icons (use Brightness.light for white icons)
      ),
    );
    context.read<CategoryBloc>().add(LoadCategory(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        final bloc = context.read<BottomNavBloc>();

        return WillPopScope(
          onWillPop: () async {
            // Handle back button for nested navigation
            if (_navigatorKeys[bloc.currentIndex].currentState?.canPop() ?? false) {
              _navigatorKeys[bloc.currentIndex].currentState?.pop();
              return false;
            }
            return true;
          },
          child: SafeArea(child: Scaffold(body: HomeScreenWidget())),
        );
      },
    );
  }

  Widget _buildNavigator(int index, Widget child) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
