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
  var token = '';
  var id = '';
  @override
  void initState() {
    token = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.token.toString() ?? '';
    id = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.userId.toString() ?? '';
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

  String validityCheck(value) {
    String validity = "days";
    if (value == 2) {
      validity = "month";
    } else if (value == 3) {
      validity = "year";
    }
    return validity;
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
          } else if (state is GetOrderIDSuccess) {
            var name = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.fullName.toString() ?? '';
            var contact = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.mobile.toString() ?? '';
            var email = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.email.toString() ?? '';
            double price = double.parse("${widget.selectedPlan?.offerPrice ?? widget.selectedPlan?.price}");
            var orderid = BlocProvider.of<PurchaseBloc>(context).orderID;
            var options = {
              'key': PaymentKeyID.keyID,
              'amount': price * 100,
              'currency': 'INR',
              'name': name,
              'order_id': state.orderID,
              'description': widget.selectedPlan?.planName ?? '',
              'prefill': {'contact': contact, 'email': email},
            };
            // 'timeout': 60, // in seconds
            // 'order_id': 'order_N1x4gRm8shFKdp', // Generate order_id using Orders API
            log(options.toString());
            if (state.orderID.toString().isNotEmpty) {
              try {
                _razorpay.open(options);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong!')));
                debugPrint('Error Payment failed: $e');
              }
            }
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
                    decoration: BoxDecoration(gradient: LinearGradient(stops: [0.0, 0.6], colors: [Color(0xffC1DDFF), Color(0xffF8F1FF)], begin: Alignment.topLeft, end: Alignment.bottomRight), color: Colors.white, border: Border.all(color: Colors.purple, width: 1), borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 1, offset: const Offset(0, 1))]),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 15),
                        Text(widget.selectedPlan?.planName ?? '', textAlign: TextAlign.center, style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: Colors.black)),
                        SizedBox(height: 25),
                        // Text("Price: ₹ ${widget.selectedPlan?.price ?? ''}", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.grey.shade700, decoration: TextDecoration.lineThrough, decorationColor: Colors.grey.shade800)),
                        // SizedBox(height: 14),
                        // Text("Offer Price: ₹ ${widget.selectedPlan?.offerPrice ?? '0'}", textAlign: TextAlign.center, style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: Colors.black)),
                        Offstage(offstage: widget.selectedPlan?.offerPrice == null || widget.selectedPlan?.offerPrice == "0", child: Text('Price: ₹${widget.selectedPlan?.price ?? ''}', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.grey.shade700, decoration: TextDecoration.lineThrough, decorationColor: Colors.grey.shade800))),
                        SizedBox(height: 14),

                        // Offer Price (prominent)
                        Offstage(offstage: widget.selectedPlan?.offerPrice == null || widget.selectedPlan?.offerPrice == "0", child: Text('Offer Price: ₹${widget.selectedPlan?.offerPrice ?? '0'}', textAlign: TextAlign.center, style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: Colors.black))),
                        Offstage(offstage: widget.selectedPlan?.offerPrice != null || widget.selectedPlan?.offerPrice == "0", child: Text('Price: ₹${widget.selectedPlan?.price ?? ''}', textAlign: TextAlign.center, style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: Colors.black))),
                        Offstage(offstage: widget.selectedPlan?.offerPrice != "0", child: Text('Price: ₹${widget.selectedPlan?.price ?? ''}', textAlign: TextAlign.center, style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: Colors.black))),

                        SizedBox(height: 14),
                        Text("Validity: ${widget.selectedPlan?.validityCount ?? ''} ${validityCheck(widget.selectedPlan?.validityUnit)}", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.grey.shade800, fontWeight: FontWeight.w700)),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple.shade600, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                            onPressed:
                                state is PurchaseLoading
                                    ? null
                                    : () {
                                      int price = 0;
                                      if (widget.selectedPlan?.offerPrice == '0' || widget.selectedPlan?.offerPrice == null) {
                                        price = int.parse("${widget.selectedPlan?.price}");
                                      } else {
                                        price = int.parse("${widget.selectedPlan?.offerPrice}");
                                      }

                                      print(price);

                                      BlocProvider.of<PurchaseBloc>(context).add(GetOrderID(amount: price.toString(), token: token, context: context));
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
