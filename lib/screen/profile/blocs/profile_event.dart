abstract class ProfileEvent {}

class LoadProfileData extends ProfileEvent {
  final context;
  final token;
  final id;
  LoadProfileData({this.context, this.token, this.id});
}
