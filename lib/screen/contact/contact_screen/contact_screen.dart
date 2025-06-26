import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/constant/app_colors/app_colors.dart';

import '../../auth/login_screen/blocs/login_bloc.dart';
import '../../widgets/appBarWidget.dart';
import '../blocs/contact_bloc.dart';
import '../blocs/contact_event.dart';
import '../blocs/contact_state.dart';
import '../models/contact_model.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  void initState() {
    final token = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.token.toString() ?? '';
    context.read<ContactBloc>().add(LoadContactInfo(token: token));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F9),
      appBar: AppBarWidget(appTitle: 'Contact Us'),
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          return state.isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                padding: EdgeInsets.all(width * 0.05),
                itemCount: state.infoList.length,
                itemBuilder: (context, index) {
                  final info = state.infoList[index];
                  return _buildContactCard(info, width, height);
                },
              );
        },
      ),
    );
  }

  Widget _buildContactCard(ContactInfo info, double width, double height) {
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.02),
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: width * 0.07, backgroundColor: Colors.blue.shade50, child: Icon(info.icon, size: width * 0.07, color: AppColors.pramarycolor)),
          SizedBox(width: width * 0.04),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(info.title, style: TextStyle(fontSize: width * 0.045, fontWeight: FontWeight.bold, color: AppColors.pramarycolor)), SizedBox(height: height * 0.004), Text(info.subtitle, style: TextStyle(color: Colors.grey[700], fontSize: width * 0.035, fontWeight: FontWeight.w400)), SizedBox(height: height * 0.008), Text(info.content, style: TextStyle(fontSize: width * 0.03))])),
        ],
      ),
    );
  }
}
