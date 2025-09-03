import 'dart:async';

import 'package:e_learning_platform/blocs/comment/comment_event.dart';
import 'package:e_learning_platform/blocs/comment/comment_state.dart';
import 'package:e_learning_platform/models/commentsmodel/comments_model.dart';
import 'package:e_learning_platform/repositories/comment_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepositories commentRepositories;

  CommentBloc(this.commentRepositories) : super(CommentInitial()) {
    on<LoadComment>(_onLoadComments);
    on<AddComment>(_onAddComment);
  }

  FutureOr<void> _onAddComment(
    AddComment event,
    Emitter<CommentState> emit,
  ) async {
    try {
      await commentRepositories.addComment(event.courseId, event.comment);
    } catch (e) {
      emit(CommentError(e.toString()));
    }
  }

  FutureOr<void> _onLoadComments(
    LoadComment event,
    Emitter<CommentState> emit,
  ) async {
    try {
      emit(CommentLoading());

      await emit.forEach<List<CommentModel>>(
        commentRepositories.getComments(event.courseId),
        onData: (comments) => CommentLoaded(comments),
        onError: (error, _) => CommentError(error.toString()),
      );
    } catch (e) {
      emit(CommentError(e.toString()));
    }
  }
}
