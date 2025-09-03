abstract class BottomNavigationEvent {}

class BottomNavigationElementPressed extends BottomNavigationEvent {
  final int index;
  BottomNavigationElementPressed({required this.index});
}
