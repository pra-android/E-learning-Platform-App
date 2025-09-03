import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_platform/models/commentsmodel/comments_model.dart';
import 'package:e_learning_platform/repositories/comment_repositories.dart';
import 'package:e_learning_platform/utilities/formvalidation/form_validation.dart';

class CommentServices implements CommentRepositories {
  final FirebaseFirestore firestore;
  CommentServices(this.firestore);
  @override
  Future<void> addComment(String courseId, CommentModel commentModel) async {
    await firestore.collection("courses").doc(courseId).update({
      "comments": FieldValue.arrayUnion([commentModel.toMap()]),
    });
    FormValidations.courseComment.clear();
  }

  @override
  Stream<List<CommentModel>> getComments(String courseId) {
    return firestore.collection("courses").doc(courseId).snapshots().map((
      snapshot,
    ) {
      final data = snapshot.data();
      if (data == null || data["comments"] == null) return [];

      final comments = (data["comments"] as List)
          .map((c) => CommentModel.fromMap(Map<String, dynamic>.from(c)))
          .toList();
      return comments;
    });
  }
}
