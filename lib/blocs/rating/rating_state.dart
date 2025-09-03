class RatingState {}

class RatingInitial extends RatingState {}

class RatingLoading extends RatingState {}

class RatingLoaded extends RatingState {
  final double averageRating;

  RatingLoaded(this.averageRating);
}

class RatingError extends RatingState {
  final String message;
  RatingError(this.message);
}
