import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_kit/media_kit.dart';
import 'package:visual_learning/screen/all_content/bloc/all_content_bloc.dart';
import 'package:visual_learning/screen/all_content/bloc/quiz_chapter/qiuz_chapter_bloc.dart';
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
import 'package:visual_learning/screen/notifications/bloc/notification_bloc.dart';
import 'package:visual_learning/screen/profile/blocs/logout/logout_bloc.dart';
import 'package:visual_learning/screen/profile/blocs/profile_bloc.dart';
import 'package:visual_learning/screen/quiz/bloc/quiz_bloc.dart';
import 'package:visual_learning/screen/quiz_screen/blocs/quiz_main_bloc.dart';
import 'package:visual_learning/screen/search_screen/blocs/search_bloc.dart';
import 'package:visual_learning/screen/share_learn/blocs/share_learn_bloc.dart';
import 'package:visual_learning/screen/splash/splash_screen.dart';
import 'package:visual_learning/screen/subcriptions/blocs/subcription_bloc.dart';
import 'package:visual_learning/screen/test_content/blocs/test_paper_content_bloc.dart';
import 'package:visual_learning/screen/test_paper/blocs/test_paper_bloc.dart';

import 'Firebase_initialize.dart';
import 'firebase_options.dart';
import 'local_notification_service.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light, // For dark icons (use Brightness.light for white icons)
    ),
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
        BlocProvider(create: (_) => SearchBloc()),
        BlocProvider(create: (_) => QiuzChapterBloc()),
        BlocProvider(create: (_) => NotificationBloc()),
        BlocProvider(create: (_) => QuizMainBloc()),
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
  LocalNotificationService initiazer = LocalNotificationService();
  final FirebaseInitialize _init = FirebaseInitialize();
  @override
  void initState() {
    _init.init();
    initiazer.initialize(context);
    FirebaseMessaging.instance.getInitialMessage();

    notifiation();
    super.initState();
  }

  Future<void> notifiation() async {
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('✅ User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('⚠️ User granted provisional permission');
    } else {
      print('❌ User declined or has not accepted permission');
    }

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("FirebaseMessaging.instance.getInitialMessage");
      if (message != null) {
        print("New Notification");

        if (message.data['_id'] != null) {}
      }
    });

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen((message) {
      print("FirebaseMessaging.onMessage.listen");

      if (message.notification != null) {
        initiazer.createanddisplaynotification(message);

        // message.data11 {driver_name:  , driver_id: 27, mobile_number: 7692898921}
      }
    });

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("FirebaseMessaging.onMessageOpenedApp.listen");
      if (message.notification != null) {}
    });

    FirebaseMessaging.instance.getToken().then((token) {
      if (kDebugMode) {
        print("FCM Token: $token");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)), home: SplashScreen());
  }
}
