import 'package:e_learning_platform/models/commentsmodel/comments_model.dart';

abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentLoaded extends CommentState {
  final List<CommentModel> commentModel;
  CommentLoaded(this.commentModel);
}

class CommentError extends CommentState {
  final String commentError;
  CommentError(this.commentError);
}
