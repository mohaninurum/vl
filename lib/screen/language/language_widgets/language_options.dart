import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/constant/app_colors/app_colors.dart';

import '../blocs/language_bloc.dart';
import '../blocs/language_event.dart';

class LanguageOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String code;
  final bool selected;

  const LanguageOption({required this.icon, required this.title, required this.code, required this.selected});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LanguageBloc>();

    return GestureDetector(
      onTap: () {
        // Navigator.pop(context);
        bloc.add(SelectLanguage(code));
      },
      child: Container(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14), decoration: BoxDecoration(color: selected ? Colors.green.shade50 : Colors.transparent, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade300)), child: Row(children: [CircleAvatar(radius: 18, backgroundColor: selected ? Colors.green : AppColors.pramarycolor, child: Icon(icon, size: 20, color: Colors.white)), SizedBox(width: 12), Expanded(child: Text(title, style: TextStyle(fontSize: 16))), if (selected) Icon(Icons.check_circle, color: Colors.green)])),
    );
  }
}
