class ProfileState {
  final String name;
  final String email;
  final String planName;
  final double planPrice;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;

  const ProfileState({required this.name, required this.email, required this.planName, required this.planPrice, required this.startDate, required this.endDate, required this.isActive});

  factory ProfileState.initial() => ProfileState(name: '', email: '', planName: '', planPrice: 0, startDate: DateTime.now(), endDate: DateTime.now(), isActive: false);
}
