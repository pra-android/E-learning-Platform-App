abstract class AuthState {
  final bool obscurePassword;
  const AuthState({this.obscurePassword = true});
}

class AuthInitial extends AuthState {
  final bool agreed;
  AuthInitial({this.agreed = false, super.obscurePassword});
}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {}

class AuthError extends AuthState {
  final String? fullNameError;
  final String? emailError;
  final String? passwordError;
  final String? generalError;
  final bool agreed;

  AuthError({
    this.fullNameError,
    this.emailError,
    this.passwordError,
    this.generalError,
    this.agreed = false,
    super.obscurePassword,
  });
}
