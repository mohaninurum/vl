import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageState('en')) {
    on<SelectLanguage>((event, emit) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      print("langauage code ${event.languageCode}");
      if (event.languageCode == "en") {
        await prefs.setString('language', "English");
        emit(LanguageState(event.languageCode));
      }
      if (event.languageCode == "hi") {
        await prefs.setString('language', "Hindi");
        emit(LanguageState(event.languageCode));
      }
    });
  }
}
