abstract class RatingRepositories {
  Future<void> submitRating(String courseId, int rating);
  Future<double> getAverageRating(String courseId);
}
