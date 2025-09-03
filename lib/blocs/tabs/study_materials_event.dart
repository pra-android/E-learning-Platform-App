abstract class StudyMaterialsEvent {}

class TabChanged extends StudyMaterialsEvent {
  final int index;
  TabChanged({required this.index});
}
