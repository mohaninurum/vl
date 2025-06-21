import 'package:bloc/bloc.dart';
import 'package:visual_learning/screen/share_learn/blocs/share_learn_event.dart';
import 'package:visual_learning/screen/share_learn/blocs/share_learn_state.dart';

class ShareBloc extends Bloc<ShareEvent, ShareState> {
  ShareBloc() : super(ShareInitial()) {
    on<ShareNowPressed>((event, emit) {
      print("click");
    });
  }
}
