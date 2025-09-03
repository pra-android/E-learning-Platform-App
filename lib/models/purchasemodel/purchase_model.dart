import 'package:cloud_firestore/cloud_firestore.dart';

class Purchase {
  final String courseId;
  final String userId;
  final String transactionId;
  final DateTime paidAt;
  final String amountPaid;
  final String courseName;

  Purchase({
    required this.courseId,
    required this.userId,
    required this.transactionId,
    required this.paidAt,
    required this.courseName,
    required this.amountPaid,
  });

  Map<String, dynamic> toMap() {
    return {
      "courseId": courseId,
      "userId": userId,
      "transactionId": transactionId,
      "paidAt": paidAt.toIso8601String(),
      "courseName": courseName,
      "amountPaid": amountPaid,
    };
  }

  factory Purchase.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Purchase(
      courseId: data["courseId"],
      userId: data["userId"],
      transactionId: data["transactionId"],
      paidAt: DateTime.parse((data["paidAt"] as Timestamp).toDate().toString()),
      courseName: data['courseName'],
      amountPaid: data['amountPaid'],
    );
  }
}
