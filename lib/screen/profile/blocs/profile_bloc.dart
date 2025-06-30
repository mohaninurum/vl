import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_learning/screen/profile/blocs/profile_event.dart';
import 'package:visual_learning/screen/profile/blocs/profile_state.dart';

import '../../../repo/api_repository_lmp.dart';
import '../models/user_subscription_details_model.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState.initial()) {
    final repository = ApiRepositoryImpl();
    on<LoadProfileData>((event, emit) async {
      try {
        emit(ProfileState(isLoading: true, name: '', email: '', planName: '', planPrice: '', startDate: '', endDate: '', isActive: ''));
        Map<String, dynamic> body = {'auth': event.token};
        final responce = await ApiRepositoryImpl().getUserSubscription(body: body, id: event.id);
        if (responce["status"] == true) {
          SubscriptionResponse Response = SubscriptionResponse.fromJson(responce);

          emit(ProfileState(isLoading: false, name: '', email: '', planName: "${Response.data?.planName ?? ''}", planPrice: "${Response.data?.price}", startDate: "${Response.data?.startDate ?? ''}", endDate: "${Response.data?.endDate ?? ''}", isActive: "${Response.data?.isActive ?? ''}"));
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(responce["message"])));
          emit(ProfileState(isLoading: false, name: '', email: '', planName: '', planPrice: '', startDate: '', endDate: '', isActive: ''));
        }
      } on TimeoutException catch (e) {
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
        emit(ProfileState(isLoading: false, name: '', email: '', planName: '', planPrice: '', startDate: '', endDate: '', isActive: ''));
      } catch (e) {
        emit(ProfileState(isLoading: false, name: '', email: '', planName: '', planPrice: '', startDate: '', endDate: '', isActive: ''));
        print("error :-$e");
        // emit(state.copyWith(isSubmitting: false, emailError: 'Something went wrong, try again.'));
      }
    });
  }
}
