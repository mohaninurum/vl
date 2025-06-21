import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/login_screen/blocs/login_bloc.dart';
import '../../../auth/login_screen/blocs/login_event.dart';

part '_logout_state.dart';
part 'logout_event.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitial()) {
    on<UserLogoutEvent>(_onUserLogout);
  }
  Future<void> _onUserLogout(UserLogoutEvent event, Emitter<LogoutState> emit) async {
    BlocProvider.of<LoginBloc>(event.context).add(GoogleLogOutEvent(event.context));
    // final url = Urls.usersLogoutUrl;
    // emit(DrawerLogoutLoading());
    // final prefs = await SharedPreferences.getInstance();
    // String? loginToken = prefs.getString('logintoken');
    // try {
    //   if (loginToken != null) {
    //     final result = await NetworkApiService().PostGetApiResponse(url, {"auth": loginToken});
    //     result.fold((error) {}, (response) {
    //       if (response["status"]) {
    //         try {
    //           ScaffoldMessenger.of(event.context).showSnackBar(
    //             SnackBar(content: Text(response['message'])),
    //           );
    //           prefs.remove('logintoken');
    //           emit(DrawerLogoutSuccess());
    //           Navigator.pushAndRemoveUntil(
    //             event.context,
    //             MaterialPageRoute(builder: (_) => Login()),
    //             (route) => false,
    //           );
    //         } catch (e) {
    //           emit(DrawerLogoutFailure());
    //           print(e);
    //         }
    //       } else {
    //         emit(DrawerLogoutFailure());
    //         ScaffoldMessenger.of(event.context).showSnackBar(
    //           SnackBar(content: Text(response['message'])),
    //         );
    //       }
    //     });
    //   }
    // } catch (e) {
    //   ScaffoldMessenger.of(event.context).showSnackBar(
    //     SnackBar(content: Text(e.toString())),
    //   );
    //   print(e);
    //   emit(DrawerLogoutFailure());
    // }
  }
}
