import 'package:e_learning_platform/models/usermodel/user_model.dart';

abstract class UserRepositories {
  Future<UserModel> getUserData(String id);
}
