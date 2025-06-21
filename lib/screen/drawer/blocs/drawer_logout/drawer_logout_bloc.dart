import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'drawer_logout_event.dart';
part 'drawer_logout_state.dart';

class DrawerLogoutBloc extends Bloc<DrawerLogoutEvent, DrawerLogoutState> {
  DrawerLogoutBloc() : super(DrawerLogoutInitial()) {
    on<UserLogoutEvent>(_onUserLogout);
  }
  Future<void> _onUserLogout(UserLogoutEvent event, Emitter<DrawerLogoutState> emit) async {
    // final url = Urls.usersLogoutUrl;
    emit(DrawerLogoutLoading());
    // final prefs = await SharedPreferences.getInstance();
    // String? loginToken = prefs.getString('logintoken');
    // try {
    //   if (loginToken != null) {
    //     final result = await NetworkApiService().PostGetApiResponse(url, {"auth": loginToken});
    //     result.fold((error) {}, (response) {
    //       if (response["status"]) {
    //         try {
    //           ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(response['message'])));
    //           prefs.remove('logintoken');
    //           emit(DrawerLogoutSuccess());
    //           Navigator.pushAndRemoveUntil(event.context, MaterialPageRoute(builder: (_) => Login()), (route) => false);
    //         } catch (e) {
    //           emit(DrawerLogoutFailure());
    //           print(e);
    //         }
    //       } else {
    //         emit(DrawerLogoutFailure());
    //         ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(response['message'])));
    //       }
    //     });
    //   }
    // } catch (e) {
    //   ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(e.toString())));
    //   print(e);
    //   emit(DrawerLogoutFailure());
    // }
  }
}
