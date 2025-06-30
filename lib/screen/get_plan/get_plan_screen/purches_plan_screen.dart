import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/screen/home_screen/home_screen/home_screen.dart';

import '../../auth/login_screen/blocs/login_bloc.dart';
import '../../subcriptions/models/subscription_plan_model.dart';
import '../../widgets/appBarWidget.dart';
import '../blocs/purchase_plan_bloc.dart';
import '../blocs/purchase_plan_event.dart';
import '../blocs/purchase_plan_state.dart';

class PurchaseScreen extends StatelessWidget {
  final SubscriptionPlan? selectedPlan;

  const PurchaseScreen({super.key, required this.selectedPlan});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (_) => PurchaseBloc(),
      child: Scaffold(
        appBar: AppBarWidget(appTitle: 'Purchase Plan'),
        body: BlocConsumer<PurchaseBloc, PurchaseState>(
          listener: (context, state) {
            if (state is PurchaseSuccess) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())); // or go to another screen
            } else if (state is PurchaseFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      width: size.width * 0.6,
                      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.green, width: 2), borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 10)]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.network('https://img.freepik.com/free-vector/accounting-app-illustration_74855-4359.jpg', height: 100),
                          const SizedBox(height: 10),
                          Text(selectedPlan?.planName ?? '', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(selectedPlan?.createdAt ?? '', style: TextStyle(color: Colors.black54)),
                          const SizedBox(height: 10),
                          Text("${selectedPlan?.price ?? ''}", style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold)),
                          Text("Offer:- ${selectedPlan?.offerPrice ?? ''}", style: TextStyle(color: Colors.green, fontSize: 16)),
                          const SizedBox(height: 10),
                          Text("Billed every year", style: TextStyle(color: Colors.black54)),
                          Text("${selectedPlan?.durationDays ?? ''} days", style: TextStyle(color: Colors.black45)),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                              onPressed:
                                  state is PurchaseLoading
                                      ? null
                                      : () {
                                        var token = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.token.toString() ?? '';
                                        var id = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.userId.toString() ?? '';
                                        context.read<PurchaseBloc>().add(StartPurchase(planId: "${selectedPlan?.planId}", userId: id, token: token, context: context));
                                      },
                              child: state is PurchaseLoading ? CircularProgressIndicator(color: Colors.white) : Text("Get", style: TextStyle(fontSize: 16, color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
