import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repo/api_repository_lmp.dart';
import '../models/contact_model.dart';
import '../models/contact_responce_model.dart';
import 'contact_event.dart';
import 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactState(infoList: [], isLoading: true)) {
    on<LoadContactInfo>((event, emit) async {
      try {
        print("load class");
        emit(ContactState(isLoading: true, infoList: []));
        Map<String, dynamic> body = {'auth': event.token};
        final responce = await ApiRepositoryImpl().getOrganization(body: body);
        if (responce["status"] == true) {
          OrganizationResponse Response = OrganizationResponse.fromJson(responce);
          final List<ContactInfo> data = [ContactInfo(title: "Our Office", subtitle: "Visit us at our headquarters", content: "${Response.data?.address}", icon: Icons.apartment), ContactInfo(title: "Phone", subtitle: "Call us directly", content: "${Response.data?.phone}", icon: Icons.phone), ContactInfo(title: "Email", subtitle: "Send us a message", content: "${Response.data?.email}", icon: Icons.email), ContactInfo(title: "Business Hours", subtitle: "When we’re available", content: "${Response.data?.businessHours}", icon: Icons.access_time), ContactInfo(title: "Customer Support", subtitle: "We're here to help", content: "${Response.data?.businessHours}", icon: Icons.support_agent)];
          emit(ContactState(infoList: data, isLoading: false));
        } else {
          ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(responce["message"])));
          emit(ContactState(isLoading: false, infoList: []));
        }
      } on TimeoutException catch (e) {
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text('Request timed out. Please try again later.')));
        emit(ContactState(isLoading: false, infoList: []));
      } catch (e) {
        emit(ContactState(isLoading: false, infoList: []));
        print("error :-$e");
        // emit(state.copyWith(isSubmitting: false, emailError: 'Something went wrong, try again.'));
      }
    });
  }
}
