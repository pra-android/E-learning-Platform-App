abstract class CourseCategoriesState {}

class CourseCategoriesIntiial extends CourseCategoriesState {}

class CourseCategoriesLoading extends CourseCategoriesState {}

class CourseCategoriesLoaded extends CourseCategoriesState {
  final List<String> categories;
  CourseCategoriesLoaded(this.categories);
}

class CourseCategoriesError extends CourseCategoriesState {
  final String error;
  CourseCategoriesError(this.error);
}
