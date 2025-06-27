class ProfileState {
  final String name;
  final String email;
  final String planName;
  final String planPrice;
  final String startDate;
  final String endDate;
  final String isActive;
  bool isLoading;

  ProfileState({required this.isLoading, required this.name, required this.email, required this.planName, required this.planPrice, required this.startDate, required this.endDate, required this.isActive});

  factory ProfileState.initial() => ProfileState(isLoading: true, name: '', email: '', planName: '', planPrice: "0", startDate: "", endDate: "", isActive: "1");
}
