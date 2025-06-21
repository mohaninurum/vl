import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/contact_model.dart';
import 'contact_event.dart';
import 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactState(infoList: [])) {
    on<LoadContactInfo>((event, emit) {
      final List<ContactInfo> data = [
        ContactInfo(title: "Our Office", subtitle: "Visit us at our headquarters", content: "Balaji Business Centre (BBC), HQ59+PWC, Pashan Hwy Side Road next to Royal Court Banquet,\nBaner, Pune, Maharashtra, 411045", icon: Icons.apartment),
        ContactInfo(title: "Phone", subtitle: "Call us directly", content: "+919718154204\nMonday - Saturday: 9:00 AM - 6:00 PM", icon: Icons.phone),
        ContactInfo(title: "Email", subtitle: "Send us a message", content: "Visuallearning247@gmail.com\nakmax123@gmail.com\nrajatdandekar@vizuara.com", icon: Icons.email),
        ContactInfo(title: "Business Hours", subtitle: "When we’re available", content: "Monday - Friday: 9:00 AM - 6:00 PM,\nSaturday: 9:00 AM - 6:00 PM \nSunday-closed ", icon: Icons.access_time),
        ContactInfo(title: "Customer Support", subtitle: "We're here to help", content: "For immediate assistance, please contact our customersupport team through any of the channels above. We aim torespond to all inquiries within 24 hours.", icon: Icons.support_agent),
      ];
      emit(ContactState(infoList: data));
    });
  }
}
