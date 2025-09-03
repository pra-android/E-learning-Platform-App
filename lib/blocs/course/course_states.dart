class CourseStates {}

class CourseInitial extends CourseStates {}

class CourseLoading extends CourseStates {}

class CourseLoaded extends CourseStates {
  List<Map<String, dynamic>> courses;
  CourseLoaded(this.courses);
}

class CourseError extends CourseStates {
  final String errorMessage;
  CourseError(this.errorMessage);
}
