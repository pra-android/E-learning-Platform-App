import 'package:e_learning_platform/blocs/rating/rating_event.dart';
import 'package:e_learning_platform/blocs/rating/rating_state.dart';
import 'package:e_learning_platform/repositories/rating_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  final RatingRepositories ratingRepositories;
  RatingBloc(this.ratingRepositories) : super(RatingInitial()) {
    on<SubmitRating>(_onSubmitRating);
    on<FetchRating>(_onFetchRating);
  }

  Future<void> _onSubmitRating(
    SubmitRating event,
    Emitter<RatingState> emit,
  ) async {
    try {
      await ratingRepositories.submitRating(event.courseId, event.rating);
      final avg = await ratingRepositories.getAverageRating(event.courseId);
      emit(RatingLoaded(avg));
    } catch (e) {
      emit(RatingError(e.toString()));
    }
  }

  Future<void> _onFetchRating(
    FetchRating event,
    Emitter<RatingState> emit,
  ) async {
    try {
      emit(RatingLoading());
      final avg = await ratingRepositories.getAverageRating(event.courseId);
      emit(RatingLoaded(avg));
    } catch (e) {
      emit(RatingError(e.toString()));
    }
  }
}
