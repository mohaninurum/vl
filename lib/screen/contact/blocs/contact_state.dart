import '../models/contact_model.dart';

class ContactState {
  final List<ContactInfo> infoList;
  bool isLoading;

  ContactState({required this.infoList, required this.isLoading});
}
