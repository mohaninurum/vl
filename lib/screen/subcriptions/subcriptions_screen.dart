import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login_screen/blocs/login_bloc.dart';
import '../auth/login_screen/blocs/login_event.dart';
import '../get_plan/get_plan_screen/purches_plan_screen.dart';
import '../home_screen/model/category_model.dart';
import '../widgets/appBarWidget.dart';
import 'blocs/subcription_bloc.dart';
import 'blocs/subcription_event.dart';
import 'blocs/subcription_state.dart';

class SubscriptionScreen extends StatefulWidget {
  BannerImageModel? bannerImageModel;
  SubscriptionScreen({super.key, this.bannerImageModel});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool isSubscription = true;
  @override
  void initState() {
    var token = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.token.toString() ?? '';
    var id = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.userId.toString() ?? '';
    var isSubscribe = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.isSubscribe.toString() ?? '';
    BlocProvider.of<SubscriptionBloc>(context).add(GetSubscriptions(context: context, token: token, id: id, isSubscribe: isSubscribe));
    super.initState();
  }

  int getDaysUntilExpiry(String endDateStr) {
    DateTime endDate = DateTime.parse(endDateStr);
    DateTime today = DateTime.now();

    // Only compare date (ignore time)
    DateTime cleanToday = DateTime(today.year, today.month, today.day);
    DateTime cleanEnd = DateTime(endDate.year, endDate.month, endDate.day);

    return cleanEnd.difference(cleanToday).inDays;
  }

  bool selectedPlan(state, index) {
    bool selected = false;
    if (state.subscriptionID.toString().isNotEmpty) {
      selected = state.subscriptionID.toString() == "${state.subscriptionPlanResponse?.data?[index].planId.toString()}";
      print("select already");
    } else {
      selected = state.selectedPlanIndex == index;
      print("select plan");
    }

    return selected;
  }

  String getValidityText(int? durationDays) {
    if (durationDays == null || durationDays <= 0) return '';

    int years = durationDays ~/ 365;
    int remainingDays = durationDays % 365;

    int months = remainingDays ~/ 30;
    int days = remainingDays % 30;

    List<String> parts = [];

    if (years > 0) {
      parts.add('$years Year${years > 1 ? 's' : ''}');
    }
    if (months > 0) {
      parts.add('$months Month${months > 1 ? 's' : ''}');
    }
    if (days > 0) {
      parts.add('$days Day${days > 1 ? 's' : ''}');
    }

    return parts.join(' ');
  }

  // String _getValidityText(int? durationDays,) {
  //   if (durationDays == null) return '';
  //
  //   if (durationDays <= 31) {
  //     return '$durationDays Days';
  //   } else if (durationDays <= 186) {
  //     int months = (durationDays / 30).round();
  //     return '$months Month${months > 1 ? 's' : ''}';
  //   } else {
  //     int years = (durationDays / 365).round();
  //     return '$years Year${years > 1 ? 's' : ''}';
  //   }
  // }

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
    var endDate = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.expiryDate ?? "2025-06-20 23:59:59";
    final isPurchase = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.isSubscribe.toString();
    return Scaffold(
      appBar: AppBarWidget(appTitle: 'Subscription'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Top banner
              widget.bannerImageModel?.imageUrl != null
                  ? Container(
                    // alignment: Alignment.bottomRight,
                    width: double.infinity,
                    height: size.height * 0.17,
                    decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(16)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        fit: StackFit.expand,
                        alignment: Alignment.center,
                        children: [
                          Hero(tag: widget.bannerImageModel?.imageUrl ?? '', child: widget.bannerImageModel?.imageUrl == null ? Image.asset("assets/images/images.png") : CachedNetworkImage(imageUrl: widget.bannerImageModel?.imageUrl ?? '', fit: BoxFit.cover, placeholder: (context, url) => const Center(child: CircularProgressIndicator()), errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)))),
                          // Align(alignment: Alignment.bottomRight, child: Text("", style: TextStyle(fontSize: size.width * 0.1, fontWeight: FontWeight.bold, color: Colors.redAccent, shadows: [Shadow(blurRadius: 5, color: Colors.black45, offset: Offset(1, 1))]))),
                        ],
                      ),
                    ),
                  )
                  : SizedBox.shrink(),
              SizedBox(height: size.height * 0.03),
              // Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: const LinearGradient(colors: [AppColors.pramarycolor, AppColors.pramarycolor1], begin: Alignment.topCenter, end: Alignment.bottomCenter)), child: Padding(padding: const EdgeInsets.all(8.0), child: Column(children: [Text("Pick a Plan to Try for free.\nYou can cancel anytime", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center), const SizedBox(height: 8), Text("Choose a plan to start after your 1 week free trial", style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center)]))),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0), //gradient: const LinearGradient(colors: [AppColors.pramarycolor, AppColors.pramarycolor1], begin: Alignment.topCenter, end: Alignment.bottomCenter)
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.blueGrey),
                child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [Text("Pick a Plane best suits for you", textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white)), const SizedBox(height: 3), Text("Access all primium content with our best subscription plan", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70, fontSize: 15, fontWeight: FontWeight.w600))]),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: BlocBuilder<SubscriptionBloc, SubscriptionState>(
                  builder: (context, state) {
                    if (state is IsLoadingSubscriptionState) {
                      return Center(child: Padding(padding: const EdgeInsets.all(20.0), child: CircularProgressIndicator()));
                    }
                    if (state is SubscriptionPlanListState) {
                      return state.subscriptionPlanResponse?.data?.isNotEmpty == true
                          ? Row(
                            children: List.generate(state.subscriptionPlanResponse?.data?.length ?? 0, (index) {
                              isSubscription = state.subscriptionID.toString() == state.subscriptionPlanResponse?.data?[index].planId.toString();
                              bool selected = selectedPlan(state, index);
                              // bool selected = state.selectedPlanIndex == index;
                              // selected = state.subscriptionID.toString().isNotEmpty ? state.subscriptionID.toString() == "${state.subscriptionPlanResponse?.data?[index].planId.toString()}" : state.selectedPlanIndex == index;
                              return GestureDetector(
                                onTap: () {
                                  print("${state.subscriptionID.toString()}");
                                  //   print("Selec Plan");
                                  context.read<SubscriptionBloc>().add(SelectPlan(index));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                                  padding: const EdgeInsets.all(20),
                                  width: 250,
                                  height: 250,
                                  decoration: BoxDecoration(gradient: LinearGradient(stops: [0.0, 0.6], colors: [Color(0xffC1DDFF), Color(0xffF8F1FF)], begin: Alignment.topLeft, end: Alignment.bottomRight), color: Colors.white, border: Border.all(color: selected ? Colors.purple : Colors.grey.shade50, width: selected ? 2 : 1), borderRadius: BorderRadius.circular(16), boxShadow: selected ? [BoxShadow(color: Colors.purple.withOpacity(0.2), blurRadius: 5, offset: const Offset(0, 2))] : [BoxShadow(color: Colors.black54, blurRadius: 1, offset: const Offset(0, 1))]),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Plan Title
                                      Text(state.subscriptionPlanResponse?.data?[index].planName ?? '', textAlign: TextAlign.center, style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: Colors.black87)),
                                      SizedBox(height: 25),

                                      // Original Price (strikethrough)
                                      Offstage(offstage: state.subscriptionPlanResponse?.data?[index].offerPrice == null || state.subscriptionPlanResponse?.data?[index].offerPrice == "0", child: Text('Price: ₹${state.subscriptionPlanResponse?.data?[index].price ?? ''}', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.grey.shade700, decoration: TextDecoration.lineThrough, decorationColor: Colors.grey.shade800))),
                                      SizedBox(height: 14),

                                      // Offer Price (prominent)
                                      Offstage(offstage: state.subscriptionPlanResponse?.data?[index].offerPrice == null || state.subscriptionPlanResponse?.data?[index].offerPrice == "0", child: Text('Offer Price: ₹${state.subscriptionPlanResponse?.data?[index].offerPrice ?? '0'}', textAlign: TextAlign.center, style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: Colors.black))),
                                      Offstage(offstage: state.subscriptionPlanResponse?.data?[index].offerPrice != null || state.subscriptionPlanResponse?.data?[index].offerPrice == "0", child: Text('Price: ₹${state.subscriptionPlanResponse?.data?[index].price ?? ''}', textAlign: TextAlign.center, style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: Colors.black))),
                                      Offstage(offstage: state.subscriptionPlanResponse?.data?[index].offerPrice != "0", child: Text('Price: ₹${state.subscriptionPlanResponse?.data?[index].price ?? ''}', textAlign: TextAlign.center, style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: Colors.black))),
                                      SizedBox(height: 14),

                                      // Validity
                                      Text('Validity: ${state.subscriptionPlanResponse?.data?[index].validityCount} ${validityCheck(state.subscriptionPlanResponse?.data[index].validityUnit)}', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Colors.grey.shade800, fontWeight: FontWeight.w700)),
                                      SizedBox(height: 20),
                                      // Action Button
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 5),
                                        child: Container(
                                          width: double.infinity,
                                          height: 30,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.purple.shade600),
                                          child:
                                              state.subscriptionID.toString() == state.subscriptionPlanResponse?.data?[index].planId.toString()
                                                  ? Center(child: Text(getDaysUntilExpiry(endDate) == 0 ? "Expires Today" : "${getDaysUntilExpiry(endDate)} days left", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)))
                                                  : MaterialButton(
                                                    onPressed:
                                                        selected
                                                            ? () {
                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => PurchaseScreen(selectedPlan: state.subscriptionPlanResponse?.data?[index])));
                                                            }
                                                            : null,
                                                    child: Text("Get", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                                                  ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          )
                          : Center(child: Text("No Record"));
                    }
                    return SizedBox.shrink();
                  },
                ),
              ),

              // SizedBox(height: size.height * 0.01),
              // Divider(),
              // SizedBox(height: size.height * 0.015),
              // isPurchase == '1' || isPurchase == '3'
              //     ? SizedBox.shrink()
              //     : InkWell(
              //       onTap: () {
              //         var token = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.token.toString() ?? '';
              //         var id = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.userId.toString() ?? '';
              //         CancelSubscriptionSheet.show(context: context, token: token, userId: id).then((value) {
              //           userCheckIsLogin(context);
              //         });
              //       },
              //       child: Container(alignment: Alignment.center, width: double.infinity, height: 40, decoration: BoxDecoration(color: Colors.purple.shade300, borderRadius: BorderRadius.circular(20)), child: Text("Cancel Subscription", style: TextStyle(color: Colors.white, fontSize: 16))),
              //     ),
            ],
          ),
        ),
      ),
    );
  }

  userCheckIsLogin(context) async {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');
    final String? password = prefs.getString('password');

    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        loginBloc.add(GoogleIsLoginEvent(context: context, displayName: "${user.displayName}", email: "${user.email}", providerId: user.providerData[0].providerId, signInMethod: user.providerData[0].providerId));
      } else if (email != null) {
        loginBloc.add(EmailChanged(email));
        loginBloc.add(PasswordChanged("$password"));
        loginBloc.add(LoginSubmitted(context));
      } else {}
    });
  }

  // Container(
  // margin: EdgeInsets.symmetric(horizontal: 8, vertical: size.height * 0.019),
  // padding: const EdgeInsets.all(16),
  // // height: size.height * 0.45,
  // width: size.width * 0.48,
  // decoration: BoxDecoration(color: Colors.white, border: Border.all(color: selected ? Colors.green : Colors.grey.shade300, width: selected ? 2 : 1), borderRadius: BorderRadius.circular(16), boxShadow: selected ? [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))] : []),
  // child: Column(
  // mainAxisSize: MainAxisSize.min,
  // children: [
  // ClipRRect(borderRadius: BorderRadius.circular(12), child: CachedNetworkImage(imageUrl: 'https://img.freepik.com/free-vector/accounting-app-illustration_74855-4359.jpg?ga=GA1.1.885131105.1747305905&semt=ais_hybrid&w=740', height: size.height * 0.099, width: size.width * 0.4, fit: BoxFit.cover, placeholder: (context, url) => const Center(child: CircularProgressIndicator()), errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red))),
  // SizedBox(height: size.height * 0.019),
  // Text(state.subscriptionPlanResponse?.data?[index].planName ?? '', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
  // SizedBox(height: size.height * 0.019),
  // Text('Description', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.black54)),
  // SizedBox(height: size.height * 0.025),
  // Text(state.subscriptionPlanResponse?.data?[index].price ?? '', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: selected ? Colors.green : Colors.black)),
  // Text("Offer:-${state.subscriptionPlanResponse?.data?[index].offerPrice ?? ''}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: selected ? Colors.green : Colors.black)),
  // SizedBox(height: size.height * 0.017),
  // Text("Billed every year", style: TextStyle(fontSize: 14, color: Colors.black54)),
  // Text(state.subscriptionPlanResponse?.data?[index].durationDays.toString() ?? '', style: TextStyle(fontSize: 13, color: Colors.black45)),
  // SizedBox(height: size.height * 0.01),
  // Container(
  // alignment: Alignment.center,
  // width: double.infinity,
  // height: size.height * 0.032,
  // decoration: BoxDecoration(color: selected ? Colors.green : Colors.blueGrey, borderRadius: BorderRadius.circular(20)),
  // child:
  // state.subscriptionID.toString() == state.subscriptionPlanResponse?.data?[index].planId.toString()
  // ? Text(getDaysUntilExpiry(endDate) == 0 ? "Today Expire" : "${getDaysUntilExpiry(endDate)} days left", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
  //     : MaterialButton(
  // onPressed: () {
  // selected ? Navigator.push(context, MaterialPageRoute(builder: (context) => PurchaseScreen(selectedPlan: state.subscriptionPlanResponse?.data?[index]))) : null;
  // },
  // child: Text("Get", style: TextStyle(color: selected ? Colors.white : Colors.white, fontSize: 16)),
  // ),
  // ),
  // ],
  // ),
  // ),
}
