import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/constant/app_colors/app_colors.dart';

import '../../auth/login_screen/blocs/login_bloc.dart';
import '../blocs/search_bloc.dart';
import '../blocs/search_event.dart';

class SearchBarWithButton extends StatefulWidget {
  const SearchBarWithButton({super.key});

  @override
  State<SearchBarWithButton> createState() => _SearchBarWithButtonState();
}

class _SearchBarWithButtonState extends State<SearchBarWithButton> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var token = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.token.toString() ?? '';
    return Row(
      children: [
        // Expanded TextField
        Expanded(child: TextField(controller: _controller, decoration: InputDecoration(hintText: 'Search...', prefixIcon: const Icon(Icons.search), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))))),
        const SizedBox(width: 10),

        // Search Button
        ElevatedButton(
          onPressed: () {
            final query = _controller.text.trim();
            if (query.isNotEmpty) {
              context.read<SearchBloc>().add(PerformSearch(query: query, token: token));
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.pramarycolor, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          child: const Text("Search", style: TextStyle(color: AppColors.appWhiteColor)),
        ),
      ],
    );
  }
}
