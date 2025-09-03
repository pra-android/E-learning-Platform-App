import 'package:e_learning_platform/blocs/tabs/study_materials_event.dart';
import 'package:e_learning_platform/blocs/tabs/study_materials_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudyMaterialsBloc
    extends Bloc<StudyMaterialsEvent, StudyMaterialsState> {
  StudyMaterialsBloc() : super(StudyMaterialTabLoadedState(0)) {
    on<TabChanged>((event, emit) {
      emit(StudyMaterialTabLoadedState(event.index));
    });
  }
}
