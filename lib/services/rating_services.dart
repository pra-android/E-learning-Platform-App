import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_platform/repositories/rating_repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RatingServices implements RatingRepositories {
  final FirebaseFirestore firestore;
  RatingServices(this.firestore);
  @override
  Future<void> submitRating(String courseId, int rating) async {
    // final user = FirebaseAuth.instance.currentUser;
    await firestore.collection("courses").doc(courseId).update({
      "ratings": FieldValue.arrayUnion([
        {"userId": FirebaseAuth.instance.currentUser!.uid, "rating": rating},
      ]),
    });
  }

  @override
  Future<double> getAverageRating(String courseId) async {
    final doc = await firestore.collection("courses").doc(courseId).get();

    if (!doc.exists) return 0.0;

    final data = doc.data() as Map<String, dynamic>;
    final ratings = (data["ratings"] ?? []) as List;

    if (ratings.isEmpty) return 0.0;

    // Extract rating values
    final ratingValues = ratings.map((r) => r["rating"] as int).toList();

    final sum = ratingValues.reduce((a, b) => a + b);
    return sum / ratingValues.length;
  }
}
