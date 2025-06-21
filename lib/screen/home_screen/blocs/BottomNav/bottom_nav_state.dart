// ======================== BOTTOM NAV STATES ========================
abstract class BottomNavState {
  const BottomNavState();
}

class BottomNavInitial extends BottomNavState {
  final int selectedIndex;
  const BottomNavInitial({this.selectedIndex = 0});
}

class BottomNavItemSelected extends BottomNavState {
  final int selectedIndex;
  final String selectedTabName;

  const BottomNavItemSelected(this.selectedIndex, this.selectedTabName);
}
