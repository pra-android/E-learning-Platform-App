import 'package:e_learning_platform/blocs/bottomnavigation/bottom_navigation_event.dart';
import 'package:e_learning_platform/blocs/bottomnavigation/bottom_navigation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(BottomNavigationState(selectedIndex: 0)) {
    on<BottomNavigationElementPressed>((event, emit) {
      emit(BottomNavigationState(selectedIndex: event.index));
    });
  }
}
