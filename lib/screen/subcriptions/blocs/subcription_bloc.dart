import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/screen/subcriptions/blocs/subcription_event.dart';
import 'package:visual_learning/screen/subcriptions/blocs/subcription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  SubscriptionBloc() : super(InitialSubscriptionState()) {
    on<SelectPlan>((event, emit) {
      emit(SelectSubscriptionState(selectedPlanIndex: event.planIndex));
    });
  }
}
