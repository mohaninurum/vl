import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:visual_learning/screen/home_screen/home_screen/home_screen.dart';

import '../../../constant/key_id.dart';
import '../../auth/login_screen/blocs/login_bloc.dart';
import '../../subcriptions/models/subscription_plan_model.dart';
import '../../widgets/appBarWidget.dart';
import '../blocs/purchase_plan_bloc.dart';
import '../blocs/purchase_plan_event.dart';
import '../blocs/purchase_plan_state.dart';

class PurchaseScreen extends StatefulWidget {
  final SubscriptionPlan? selectedPlan;

  const PurchaseScreen({super.key, required this.selectedPlan});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  final _razorpay = Razorpay();

  @override
  void initState() {
    initializingRazorpay();
    super.initState();
  }

  initializingRazorpay() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("orderId: ${response.orderId}");
    print("paymentId: ${response.paymentId}");
    print("signature: ${response.signature.toString()}");
    var token = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.token.toString() ?? '';
    var id = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.userId.toString() ?? '';
    BlocProvider.of<PurchaseBloc>(context).add(StartPurchase(planId: "${widget.selectedPlan?.planId}", userId: id, token: token, context: context));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.orderId ?? '')));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Code: ${response.code}");
    print("Message: ${response.message}");
    print("Metadata: ${response.error.toString()}");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.error.toString())));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
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
                        Text(widget.selectedPlan?.planName ?? '', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Description', style: TextStyle(color: Colors.black54)),
                        const SizedBox(height: 10),
                        Text("${widget.selectedPlan?.price ?? ''}", style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold)),
                        Text("Offer:- ${widget.selectedPlan?.offerPrice ?? ''}", style: TextStyle(color: Colors.green, fontSize: 16)),
                        const SizedBox(height: 10),
                        Text("Billed every year", style: TextStyle(color: Colors.black54)),
                        Text("${widget.selectedPlan?.durationDays ?? ''} days", style: TextStyle(color: Colors.black45)),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                            onPressed:
                                state is PurchaseLoading
                                    ? null
                                    : () {
                                      var name = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.fullName.toString() ?? '';
                                      var contact = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.mobile.toString() ?? '';
                                      var email = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.email.toString() ?? '';
                                      var options = {
                                        'key': PaymentKeyID.keyID,
                                        'amount': int.parse("${widget.selectedPlan?.price}") * 100,
                                        'currency': 'INR',
                                        'name': name,
                                        'description': widget.selectedPlan?.planName ?? '',

                                        'prefill': {'contact': contact, 'email': email},
                                      };
                                      // 'timeout': 60, // in seconds
                                      // 'order_id': 'order_N1x4gRm8shFKdp', // Generate order_id using Orders API
                                      log(options.toString());
                                      try {
                                        _razorpay.open(options);
                                      } catch (e) {
                                        debugPrint('Error Payment failed: $e');
                                      }
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
    );
  }
}
