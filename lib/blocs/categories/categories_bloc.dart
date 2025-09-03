import 'package:e_learning_platform/blocs/categories/categories_event.dart';
import 'package:e_learning_platform/blocs/categories/categories_state.dart';
import 'package:e_learning_platform/repositories/course_categories_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CourseCategoriesState> {
  final CourseCategoriesRepositories categoriesRepositories;
  CategoriesBloc(this.categoriesRepositories)
    : super(CourseCategoriesIntiial()) {
    on<LoadCategoriesEvent>((event, emit) async {
      try {
        emit(CourseCategoriesLoading());
        final realdata = await categoriesRepositories.getCourseCategories();
        emit(CourseCategoriesLoaded(realdata));
      } catch (e) {
        emit(CourseCategoriesError(e.toString()));
      }
    });
  }
}
