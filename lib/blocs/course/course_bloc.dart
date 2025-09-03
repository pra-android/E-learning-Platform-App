import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_platform/blocs/course/course_event.dart';
import 'package:e_learning_platform/blocs/course/course_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseBloc extends Bloc<CourseEvent, CourseStates> {
  final FirebaseFirestore firestore;
  CourseBloc(this.firestore) : super(CourseInitial()) {
    on<LoadCoursesbyCategory>((event, emit) async {
      emit(CourseLoading());
      try {
        final snapshot = await firestore
            .collection("courses")
            .where("category", isEqualTo: event.category)
            .get();

        final courses = snapshot.docs.map((doc) => doc.data()).toList();

        emit(CourseLoaded(courses));
      } catch (e) {
        emit(CourseError(e.toString()));
      }
    });
  }
}
