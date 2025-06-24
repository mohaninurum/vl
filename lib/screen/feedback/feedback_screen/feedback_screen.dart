import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/constant/app_colors/app_colors.dart';

import '../../auth/login_screen/blocs/login_bloc.dart';
import '../../widgets/appBarWidget.dart';
import '../blocs/feedback_bloc.dart';
import '../blocs/feedback_event.dart';
import '../blocs/feedback_state.dart';
import '../models/feedback_list_model.dart';

class FeedbackScreen extends StatefulWidget {
  FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final nameController = TextEditingController();

  final messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final token = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.token.toString() ?? '';
    context.read<FeedbackBloc>().add(GetFeedbackList(context: context, token: token));
    // context.read<ClassListBloc>().add(LoadClassList(id: widget.id, context: context));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F9),
      appBar: AppBarWidget(appTitle: 'Feedback'),
      body: BlocBuilder<FeedbackBloc, FeedbackState>(
        builder: (context, state) {
          return InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
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
                  if (state.feedbacks?.data.length != 0) ...?state.feedbacks?.data.map((feedback) => _buildFeedbackCard(feedback, width)),
                  if (state.feedbacks?.data.length == 0) Text("No Record"),
                  SizedBox(height: height * 0.04),
                ],
              ),
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
    return BlocBuilder<FeedbackBloc, FeedbackState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.pramarycolor, padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 3), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))),
            onPressed: () {
              final token = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.token.toString() ?? '';
              if (nameCtrl.text.isNotEmpty && msgCtrl.text.isNotEmpty) {
                context.read<FeedbackBloc>().add(SubmitFeedback(context: context, name: nameCtrl.text, message: msgCtrl.text, token: token));
                nameCtrl.clear();
                msgCtrl.clear();
                FocusManager.instance.primaryFocus?.unfocus();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Field cannot be empty.")));
              }
            },
            child: state.isSubmitting ? const Text("Submit Feedback", style: TextStyle(fontSize: 16, color: Colors.white)) : CircularProgressIndicator(color: Colors.white),
          ),
        );
      },
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
          Text(feedback.fullName, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(feedback.feedback),
          const SizedBox(height: 4),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("${feedback.createdAt.day}/${feedback.createdAt.month}/${feedback.createdAt.year}", style: const TextStyle(fontSize: 12, color: Colors.grey)), Text("${feedback.createdAt.hour}:${feedback.createdAt.minute.toString().padLeft(2, '0')}", style: const TextStyle(fontSize: 12, color: Colors.grey))]),
        ],
      ),
    );
  }
}
