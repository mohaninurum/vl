import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/language_bloc.dart';
import 'blocs/language_state.dart';
import 'language_widgets/language_options.dart';

Future<void> showLanguageBottomSheet(BuildContext context) async {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (context) {
      final height = MediaQuery.of(context).size.height;
      final width = MediaQuery.of(context).size.width;

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: height * 0.07),
        child: BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(height: 5, width: 40, margin: const EdgeInsets.only(bottom: 16), decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
                Text("Choose Your Language", style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.045)), //
                SizedBox(height: height * 0.02), LanguageOption(icon: Icons.language, title: "English", code: 'en', selected: state.selectedLanguage == 'en'), //
                SizedBox(height: height * 0.015), LanguageOption(icon: Icons.language, title: "Hindi", code: 'hi', selected: state.selectedLanguage == 'hi'),
              ],
            );
          },
        ),
      );
    },
  );
}
