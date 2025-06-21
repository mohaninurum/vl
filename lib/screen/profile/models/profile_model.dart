class AccountState {
  final String name;
  final String email;
  final String planName;
  final double planPrice;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;

  AccountState({required this.name, required this.email, required this.planName, required this.planPrice, required this.startDate, required this.endDate, required this.isActive});
}
