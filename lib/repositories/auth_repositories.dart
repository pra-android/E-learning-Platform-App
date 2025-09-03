import 'package:flutter/widgets.dart';

abstract class AuthRepositories {
  Future<void> signup(
    String fullname,
    String email,
    String password,
    BuildContext context,
  );

  Future<void> login(String email, String password);

  Future<void> forgotPassword(String email, BuildContext context);

  Future<void> logout();
}
