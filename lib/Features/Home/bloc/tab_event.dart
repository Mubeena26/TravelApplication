abstract class TabEvent {}

class ChangeTab extends TabEvent {
  final int index;

  ChangeTab(this.index);
}
