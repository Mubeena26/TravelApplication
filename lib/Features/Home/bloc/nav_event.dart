abstract class NavEvent {}

class ChangeNav extends NavEvent {
  final int index;

  ChangeNav(this.index);
}
