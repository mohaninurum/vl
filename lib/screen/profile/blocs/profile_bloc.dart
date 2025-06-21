import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/screen/profile/blocs/profile_event.dart';
import 'package:visual_learning/screen/profile/blocs/profile_state.dart';

import '../../../repo/api_repository_lmp.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState.initial()) {
    final repository = ApiRepositoryImpl();
    on<LoadProfileData>((event, emit) async {
      emit(ProfileState(name: 'mohan', email: 'mohan.inurum@gmail.com', planName: 'Premium', planPrice: 399.0, startDate: DateTime(2025, 6, 11), endDate: DateTime(2025, 7, 11), isActive: true));
    });
  }
}
