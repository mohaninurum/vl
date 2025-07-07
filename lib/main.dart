import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/screen/all_content/bloc/all_content_bloc.dart';
import 'package:visual_learning/screen/auth/login_screen/blocs/login_bloc.dart';
import 'package:visual_learning/screen/auth/singup_screen/blocs/signup_bloc.dart';
import 'package:visual_learning/screen/chapter/blocs/chapter_bloc.dart';
import 'package:visual_learning/screen/chapter/blocs/subjecttab_bloc.dart';
import 'package:visual_learning/screen/classes/bloc/classes_bloc.dart';
import 'package:visual_learning/screen/contact/blocs/contact_bloc.dart';
import 'package:visual_learning/screen/drawer/blocs/drawer_logout/drawer_logout_bloc.dart';
import 'package:visual_learning/screen/favorite/blocs/favorite_bloc.dart';
import 'package:visual_learning/screen/feedback/blocs/feedback_bloc.dart';
import 'package:visual_learning/screen/get_plan/blocs/purchase_plan_bloc.dart';
import 'package:visual_learning/screen/home_screen/blocs/BottomNav/bottom_nav_bloc.dart';
import 'package:visual_learning/screen/home_screen/blocs/CategorySelected/_category_selected_bloc.dart';
import 'package:visual_learning/screen/home_screen/blocs/category/category_bloc.dart';
import 'package:visual_learning/screen/language/blocs/language_bloc.dart';
import 'package:visual_learning/screen/notes/blocs/get_notes/get_notes_list_bloc.dart';
import 'package:visual_learning/screen/notes/blocs/get_subject/get_subject_bloc.dart';
import 'package:visual_learning/screen/notes/blocs/notes_bloc/notes_bloc.dart';
import 'package:visual_learning/screen/notes_content/blocs/notes_content_bloc.dart';
import 'package:visual_learning/screen/profile/blocs/logout/logout_bloc.dart';
import 'package:visual_learning/screen/profile/blocs/profile_bloc.dart';
import 'package:visual_learning/screen/quiz/bloc/quiz_bloc.dart';
import 'package:visual_learning/screen/share_learn/blocs/share_learn_bloc.dart';
import 'package:visual_learning/screen/splash/splash_screen.dart';
import 'package:visual_learning/screen/subcriptions/blocs/subcription_bloc.dart';
import 'package:visual_learning/screen/test_content/blocs/test_paper_content_bloc.dart';
import 'package:visual_learning/screen/test_paper/blocs/test_paper_bloc.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light, // For dark icons (use Brightness.light for white icons)
    ),
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ClassListBloc()),
        BlocProvider(create: (_) => ShareBloc()),
        BlocProvider(create: (_) => SubscriptionBloc()),
        BlocProvider(create: (_) => DrawerLogoutBloc()),
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => ProfileBloc()),
        BlocProvider(create: (_) => ChapterContentBloc()),
        BlocProvider(create: (_) => LogoutBloc()),
        BlocProvider(create: (_) => ContactBloc()),
        BlocProvider(create: (_) => TestPaperBloc()),
        BlocProvider(create: (_) => FeedbackBloc()),
        BlocProvider(create: (_) => NotesBloc()),
        BlocProvider(create: (_) => GetSubjectBloc()),
        BlocProvider(create: (_) => GetNotesListBloc()),
        BlocProvider(create: (_) => QuizBloc()),
        BlocProvider(create: (_) => SubjectTabBloc()),
        BlocProvider(create: (_) => BottomNavBloc()),
        BlocProvider(create: (_) => CategorySelectedBloc()),
        BlocProvider(create: (_) => CategoryBloc()),
        BlocProvider(create: (_) => SignUpBloc()),
        BlocProvider(create: (_) => ChapterListBloc()),
        BlocProvider(create: (_) => LanguageBloc()),
        BlocProvider(create: (_) => NotesContentBloc()),
        BlocProvider(create: (_) => TestPaperContentBloc()),
        BlocProvider(create: (_) => TestPaperContentBloc()),
        BlocProvider(create: (_) => PurchaseBloc()),
        BlocProvider(create: (_) => FavoriteBloc()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)), home: SplashScreen());
  }
}
