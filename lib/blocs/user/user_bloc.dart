import 'package:e_learning_platform/blocs/user/user_event.dart';
import 'package:e_learning_platform/blocs/user/user_states.dart';
import 'package:e_learning_platform/repositories/user_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserStates> {
  final UserRepositories userRepository;
  UserBloc(this.userRepository) : super(UserInitial()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await userRepository.getUserData(event.uid);
        emit(UserLoaded(user));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
