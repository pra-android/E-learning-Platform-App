import 'package:e_learning_platform/models/commentsmodel/comments_model.dart';

abstract class CommentRepositories {
  Future<void> addComment(String courseId, CommentModel commentModel);
  Stream<List<CommentModel>> getComments(String courseId);
}
