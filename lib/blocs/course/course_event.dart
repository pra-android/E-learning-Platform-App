abstract class CourseEvent {}

class LoadCoursesbyCategory extends CourseEvent {
  final String category;
  LoadCoursesbyCategory(this.category);
}
