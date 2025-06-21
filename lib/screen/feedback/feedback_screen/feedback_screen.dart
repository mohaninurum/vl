import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/constant/app_colors/app_colors.dart';

import '../../widgets/appBarWidget.dart';
import '../blocs/feedback_bloc.dart';
import '../blocs/feedback_event.dart';
import '../blocs/feedback_state.dart';
import '../models/feedback_model.dart';

class FeedbackScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final messageController = TextEditingController();

  FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F9),
      appBar: AppBarWidget(appTitle: 'Feedback'),
      body: BlocBuilder<FeedbackBloc, FeedbackState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.03),
                _buildHeaderSection(),
                SizedBox(height: height * 0.02),
                Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black12)]), padding: const EdgeInsets.all(17), child: Column(children: [_buildTextField("Your Name", nameController), SizedBox(height: height * 0.015), _buildTextField("Feedback Message", messageController, maxLines: 4)])),
                SizedBox(height: height * 0.025),
                _buildSubmitButton(context, nameController, messageController),
                SizedBox(height: height * 0.04),
                Container(alignment: Alignment.center, width: width * 0.89, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black12)]), padding: const EdgeInsets.all(13), child: const Text("Previous Feedback", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                SizedBox(height: height * 0.01),
                ...state.feedbacks.reversed.map((feedback) => _buildFeedbackCard(feedback, width)),
                SizedBox(height: height * 0.04),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(alignment: Alignment.center, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black12)]), padding: const EdgeInsets.all(14), child: const Column(crossAxisAlignment: CrossAxisAlignment.center, children: [Text("Share Your Experience", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), SizedBox(height: 8), Center(child: Text("Help us improve by providing your valuable feedback", style: TextStyle(color: Colors.grey)))]));
  }

  Widget _buildTextField(String hint, TextEditingController controller, {int maxLines = 1}) {
    return TextField(controller: controller, maxLines: maxLines, decoration: InputDecoration(hintText: hint, filled: true, fillColor: Colors.white, contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey, width: 2))));
  }

  Widget _buildSubmitButton(BuildContext context, TextEditingController nameCtrl, TextEditingController msgCtrl) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.pramarycolor, padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 3), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))),
        onPressed: () {
          if (nameCtrl.text.isNotEmpty && msgCtrl.text.isNotEmpty) {
            context.read<FeedbackBloc>().add(SubmitFeedback(nameCtrl.text, msgCtrl.text));
            nameCtrl.clear();
            msgCtrl.clear();
            FocusManager.instance.primaryFocus?.unfocus();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Field cannot be empty.")));
          }
        },
        child: const Text("Submit Feedback", style: TextStyle(fontSize: 16, color: Colors.white)),
      ),
    );
  }

  Widget _buildFeedbackCard(FeedbackModel feedback, double width) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(blurRadius: 3, color: Colors.black12)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(feedback.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(feedback.message),
          const SizedBox(height: 4),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("${feedback.time.day}/${feedback.time.month}/${feedback.time.year}", style: const TextStyle(fontSize: 12, color: Colors.grey)), Text("${feedback.time.hour}:${feedback.time.minute.toString().padLeft(2, '0')}", style: const TextStyle(fontSize: 12, color: Colors.grey))]),
        ],
      ),
    );
  }
}
