import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/login_screen/blocs/login_bloc.dart';
import '../../auth/login_screen/blocs/login_event.dart';
import '../blocs/cancel_subscription_bloc.dart';
import '../blocs/cancel_subscription_event.dart';
import '../blocs/cancel_subscription_state.dart';

class CancelSubscriptionSheet {
  static Future<void> show({required BuildContext context, required String userId, required String token}) {
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

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) {
        return BlocProvider(
          create: (_) => CancelSubscriptionBloc(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: BlocConsumer<CancelSubscriptionBloc, CancelSubscriptionState>(
              listener: (context, state) async {
                if (state is CancelSuccess) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 40),
                    const SizedBox(height: 16),
                    const Text("Cancel Subscription", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),
                    const Text(
                      "Are you sure you want to cancel your subscription? "
                      "You’ll lose access to subscription features.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 24),
                    if (state is CancelLoading)
                      const CircularProgressIndicator()
                    else
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Keep Subscription"),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                              onPressed: () {
                                context.read<CancelSubscriptionBloc>().add(CancelSubscriptionRequested(userId: userId, token: token, context: context));
                                // userCheckIsLogin(context);
                              },
                              child: const Text("Submit"),
                            ),
                          ),
                        ],
                      ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
