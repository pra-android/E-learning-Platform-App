import '../../models/commentsmodel/comments_model.dart';

abstract class CommentEvent {}

class LoadComment extends CommentEvent {
  final String courseId;
  LoadComment(this.courseId);
}

class AddComment extends CommentEvent {
  final String courseId;
  final CommentModel comment;
  AddComment(this.courseId, this.comment);
}
