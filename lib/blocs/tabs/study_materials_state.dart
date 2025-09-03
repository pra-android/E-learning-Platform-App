abstract class StudyMaterialsState {}

class StudyMaterialTabLoadedState extends StudyMaterialsState {
  final int selectedIndex;
  StudyMaterialTabLoadedState(this.selectedIndex);
}
