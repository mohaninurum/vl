import 'package:flutter/material.dart';

import '../../constant/app_colors/app_colors.dart';
import '../contact/models/contact_model.dart';
import '../widgets/appBarWidget.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBarWidget(appTitle: 'About us'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Gradient Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF3F0071), Color(0xFFCB6CE6)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("About Us", style: TextStyle(fontSize: width * 0.08, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 16),
                  Text("Vizuaara is an Indian EdTech organization, formed at MIT, USA. The founding team is alumni from MIT (USA) and Purdue University (USA), also gold medalists from IIT Madras. At Vizuaara, we believe that if science is taught in a highly visual and immersive way, students can truly appreciate its beauty. Through the power of hyper-realistic 3D models, highly engaging virtual labs and immersive 3D videos: Vizuaara aims to transform teachers into super teachers and students into better learners. Through these high quality, state of the art virtual labs, we bring out the hidden potential in students and nurture them to be future scientists.", style: TextStyle(fontSize: width * 0.04, color: Colors.white, height: 1.5)),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Founders Section
            Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Align(alignment: Alignment.centerLeft, child: Text("Founders", style: TextStyle(fontSize: width * 0.06, fontWeight: FontWeight.bold)))),
            const SizedBox(height: 16),

            // Founders Grid
            Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Wrap(spacing: 16, runSpacing: 16, alignment: WrapAlignment.center, children: const [FounderCard(name: "Dr. Raj Dandekar", details: "IIT Madras BTech, MIT PhD"), FounderCard(name: "Dr. Rajat Dandekar", details: "IIT Madras MTech, Purdue PhD"), FounderCard(name: "Dr. Sreedath Panat", details: "IIT Madras BTech, MIT PhD")])),
            const SizedBox(height: 40), Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Wrap(spacing: 16, runSpacing: 16, alignment: WrapAlignment.center, children: [_buildContactCard(ContactInfo(subtitle: "", icon: Icons.science, title: 'Virtual Labs', content: "Step into the future of learning with our virtual labs. We bridge the gap between theory and practice, offering an interactive and realistic environment where students, researchers, and enthusiasts can explore, experiment, and learn"), width, height)])),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class FounderCard extends StatelessWidget {
  final String name;
  final String details;

  const FounderCard({super.key, required this.name, required this.details});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.8, // Responsive width
      constraints: const BoxConstraints(maxWidth: 300),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF3F0071), Color(0xFFCB6CE6)], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(16)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [Text(name, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)), const SizedBox(height: 8), Text(details, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 14))]),
    );
  }
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
