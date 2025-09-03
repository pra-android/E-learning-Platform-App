import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_platform/models/usermodel/user_model.dart';
import 'package:e_learning_platform/repositories/user_repositories.dart';

class UserServices implements UserRepositories {
  final FirebaseFirestore firebaseFirestore;
  UserServices(this.firebaseFirestore);

  @override
  Future<UserModel> getUserData(String id) async {
    //getting DocumentSnapshot<Map<String, dynamic>>
    final doc = await firebaseFirestore.collection('users').doc(id).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    } else {
      throw Exception("User not found");
    }
  }
}
