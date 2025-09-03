import 'package:flutter/material.dart';

abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  LoginRequested(this.email, this.password);
}

class ToggleAgreement extends AuthEvent {
  final bool agreed;
  ToggleAgreement(this.agreed);
}

class TogglePasswordVisibility extends AuthEvent {
  TogglePasswordVisibility();
}

class SignupRequested extends AuthEvent {
  final String email;
  final String password;
  final String fullname;
  final BuildContext context;

  SignupRequested({
    required this.email,
    required this.password,
    required this.fullname,
    required this.context,
  });
}

class LogoutRequested extends AuthEvent {}

class ForgotPasswordRequested extends AuthEvent {
  final String email;
  final BuildContext context;
  ForgotPasswordRequested({required this.email, required this.context});
}
