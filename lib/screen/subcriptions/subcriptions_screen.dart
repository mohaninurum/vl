import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/login_screen/blocs/login_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var endDate = BlocProvider.of<LoginBloc>(context).loginResponse?.user?.expiryDate ?? "2025-06-20 23:59:59";
    return Scaffold(
      appBar: AppBarWidget(appTitle: 'Subscription'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Top banner
              Container(
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
                      Align(alignment: Alignment.bottomRight, child: Text("-50%", style: TextStyle(fontSize: size.width * 0.1, fontWeight: FontWeight.bold, color: Colors.redAccent, shadows: [Shadow(blurRadius: 5, color: Colors.black45, offset: Offset(1, 1))]))),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              // Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), gradient: const LinearGradient(colors: [AppColors.pramarycolor, AppColors.pramarycolor1], begin: Alignment.topCenter, end: Alignment.bottomCenter)), child: Padding(padding: const EdgeInsets.all(8.0), child: Column(children: [Text("Pick a Plan to Try for free.\nYou can cancel anytime", style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center), const SizedBox(height: 8), Text("Choose a plan to start after your 1 week free trial", style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center)]))),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0), //gradient: const LinearGradient(colors: [AppColors.pramarycolor, AppColors.pramarycolor1], begin: Alignment.topCenter, end: Alignment.bottomCenter)
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.blueGrey),
                child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [Text("Pick a Plan to Try for Free.\nYou can cancel anytime", textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)), const SizedBox(height: 3), Text("Choose a plan to start after your 1 week free trial", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70, fontSize: 14))]),
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
                                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: size.height * 0.019),
                                  padding: const EdgeInsets.all(16),
                                  // height: size.height * 0.45,
                                  width: size.width * 0.48,
                                  decoration: BoxDecoration(color: Colors.white, border: Border.all(color: selected ? Colors.green : Colors.grey.shade300, width: selected ? 2 : 1), borderRadius: BorderRadius.circular(16), boxShadow: selected ? [BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))] : []),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipRRect(borderRadius: BorderRadius.circular(12), child: CachedNetworkImage(imageUrl: 'https://img.freepik.com/free-vector/accounting-app-illustration_74855-4359.jpg?ga=GA1.1.885131105.1747305905&semt=ais_hybrid&w=740', height: size.height * 0.099, width: size.width * 0.4, fit: BoxFit.cover, placeholder: (context, url) => const Center(child: CircularProgressIndicator()), errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red))),
                                      SizedBox(height: size.height * 0.019),
                                      Text(state.subscriptionPlanResponse?.data?[index].planName ?? '', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                      SizedBox(height: size.height * 0.019),
                                      Text('Description', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.black54)),
                                      SizedBox(height: size.height * 0.025),
                                      Text(state.subscriptionPlanResponse?.data?[index].price ?? '', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: selected ? Colors.green : Colors.black)),
                                      Text("Offer:-${state.subscriptionPlanResponse?.data?[index].offerPrice ?? ''}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: selected ? Colors.green : Colors.black)),
                                      SizedBox(height: size.height * 0.017),
                                      Text("Billed every year", style: TextStyle(fontSize: 14, color: Colors.black54)),
                                      Text(state.subscriptionPlanResponse?.data?[index].durationDays.toString() ?? '', style: TextStyle(fontSize: 13, color: Colors.black45)),
                                      SizedBox(height: size.height * 0.01),
                                      Container(
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        height: size.height * 0.032,
                                        decoration: BoxDecoration(color: selected ? Colors.green : Colors.blueGrey, borderRadius: BorderRadius.circular(20)),
                                        child:
                                            state.subscriptionID.toString() == state.subscriptionPlanResponse?.data?[index].planId.toString()
                                                ? Text(getDaysUntilExpiry(endDate) == 0 ? "Today Expire" : "${getDaysUntilExpiry(endDate)} days left", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                                                : MaterialButton(
                                                  onPressed: () {
                                                    selected ? Navigator.push(context, MaterialPageRoute(builder: (context) => PurchaseScreen(selectedPlan: state.subscriptionPlanResponse?.data?[index]))) : null;
                                                  },
                                                  child: Text("Get", style: TextStyle(color: selected ? Colors.white : Colors.white, fontSize: 16)),
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

              SizedBox(height: size.height * 0.01),
              const Text("What is Brainly Tutor?"),
            ],
          ),
        ),
      ),
    );
  }
}
