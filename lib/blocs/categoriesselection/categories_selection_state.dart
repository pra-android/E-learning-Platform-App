abstract class CategorySelectionState {}

class CategoryInitial extends CategorySelectionState {}

class CategorySelected extends CategorySelectionState {
  final String category;
  CategorySelected(this.category);
}
