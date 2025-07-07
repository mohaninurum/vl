import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visual_learning/constant/app_colors/app_colors.dart';

import '../blocs/language_bloc.dart';
import '../blocs/language_event.dart';

class LanguageOption extends StatefulWidget {
  final IconData icon;
  final String title;
  final String code;
  final bool selected;

  const LanguageOption({required this.icon, required this.title, required this.code, required this.selected});

  @override
  State<LanguageOption> createState() => _LanguageOptionState();
}

class _LanguageOptionState extends State<LanguageOption> {
  String lannguagecode = 'en';
  @override
  void initState() {
    getLanguage();
    super.initState();
  }

  getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? language = prefs.getString('language');
    if (language == "English") {
      lannguagecode = 'en';
    }
    if (language == "Hindi") {
      lannguagecode = 'hi';
    }
    // Navigator.pop(context);
    context.read<LanguageBloc>().add(SelectLanguage(lannguagecode));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LanguageBloc>();
    lannguagecode = widget.code;
    return GestureDetector(
      onTap: () async {
        // Navigator.pop(context);
        bloc.add(SelectLanguage(lannguagecode));
      },
      child: Container(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14), decoration: BoxDecoration(color: widget.selected ? Colors.green.shade50 : Colors.transparent, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)), child: Row(children: [CircleAvatar(radius: 18, backgroundColor: widget.selected ? Colors.green : AppColors.pramarycolor, child: Icon(widget.icon, size: 20, color: Colors.white)), SizedBox(width: 12), Expanded(child: Text(widget.title, style: TextStyle(fontSize: 16))), if (widget.selected) Icon(Icons.check_circle, color: Colors.green)])),
    );
  }
}
