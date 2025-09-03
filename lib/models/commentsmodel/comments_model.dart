class CommentModel {
  final String userId;
  final String username;
  final String comment;
  final DateTime createdAt;

  CommentModel({
    required this.userId,
    required this.username,
    required this.comment,
    required this.createdAt,
  });

  // Convert from Firestore
  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      userId: map['userId'] ?? '',
      username: map['username'] ?? '',
      comment: map['comment'] ?? '',
      createdAt: DateTime.parse(map["createdAt"]),
    );
  }

  // Convert to Firestore
  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "username": username,
      "comment": comment,
      "createdAt": createdAt.toIso8601String(),
    };
  }
}
