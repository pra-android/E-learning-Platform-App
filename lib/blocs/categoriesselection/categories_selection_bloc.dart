import 'package:e_learning_platform/blocs/categoriesselection/categories_selection_event.dart';
import 'package:e_learning_platform/blocs/categoriesselection/categories_selection_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorySelectionBloc
    extends Bloc<CategorySelectionEvent, CategorySelectionState> {
  CategorySelectionBloc() : super(CategoryInitial()) {
    on<SelectCategoryEvent>((event, emit) {
      emit(CategorySelected(event.category));
    });
  }
}
