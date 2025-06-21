abstract class BottomNavEvent {
  const BottomNavEvent();
}

class BottomNavItemTapped extends BottomNavEvent {
  final int index;
  final String tabName;

  const BottomNavItemTapped(this.index, this.tabName);
}

class BottomNavReset extends BottomNavEvent {}
