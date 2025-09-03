abstract class CategorySelectionEvent {}

class SelectCategoryEvent extends CategorySelectionEvent {
  final String category;
  SelectCategoryEvent(this.category);
}
