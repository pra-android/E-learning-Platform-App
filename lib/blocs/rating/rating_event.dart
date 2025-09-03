abstract class RatingEvent {}

class FetchRating extends RatingEvent {
  final String courseId;
  FetchRating(this.courseId);
}

class SubmitRating extends RatingEvent {
  final String courseId;
  final int rating; // 1–5 stars
  SubmitRating(this.courseId, this.rating);
}
