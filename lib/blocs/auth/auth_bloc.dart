import 'package:e_learning_platform/blocs/auth/auth_event.dart';
import 'package:e_learning_platform/blocs/auth/auth_state.dart';
import 'package:e_learning_platform/repositories/auth_repositories.dart';
import 'package:e_learning_platform/utilities/formvalidation/form_validation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositories authRepositories;

  AuthBloc(this.authRepositories) : super(AuthInitial()) {
    //login state
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepositories.login(event.email, event.password);
        emit(Authenticated());
      } catch (e) {
        FormValidations.loginEmailController.clear();
        FormValidations.loginPasswordController.clear();
        emit(AuthError(generalError: e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
      try {
        await authRepositories.logout();
        emit(AuthInitial());
        FormValidations.loginEmailController.clear();
        FormValidations.loginPasswordController.clear();
      } catch (e) {
        emit(AuthError(generalError: e.toString()));
      }
    });

    on<TogglePasswordVisibility>((event, emit) {
      final isHidden = state.obscurePassword;
      if (state is AuthInitial) {
        final current = state as AuthInitial;
        emit(
          AuthInitial(
            agreed: current.agreed,
            obscurePassword: !current.obscurePassword,
          ),
        );
      } else if (state is AuthError) {
        final current = state as AuthError;
        emit(
          AuthError(
            fullNameError: current.fullNameError,
            emailError: current.emailError,
            passwordError: current.passwordError,
            generalError: null,
            agreed: current.agreed,
            obscurePassword: !isHidden,
          ),
        );
      } else {
        emit(AuthInitial(obscurePassword: !isHidden));
      }
    });

    on<ToggleAgreement>((event, emit) {
      final currentState = state;
      if (currentState is AuthInitial) {
        emit(AuthInitial(agreed: event.agreed));
      } else if (currentState is AuthError) {
        emit(
          AuthError(
            fullNameError: currentState.fullNameError,
            emailError: currentState.emailError,
            passwordError: currentState.passwordError,
            generalError: currentState.generalError,
            agreed: event.agreed,
          ),
        );
      }
    });

    //forgot password state
    on<ForgotPasswordRequested>((event, emit) async {
      final email = event.email.trim();
      if (!GetUtils.isEmail(email)) {
        emit(AuthError(emailError: "Please enter a valid email"));
        return;
      } else {
        try {
          await authRepositories.forgotPassword(email, event.context);
        } catch (e) {
          emit(AuthError(generalError: "Failed to send reset link: $e"));
        } finally {
          FormValidations.forgotPasswordController.clear();
        }
      }
    });

    //signup state
    on<SignupRequested>((event, emit) async {
      String? emailError;
      String? fullNameError;
      String? passwordError;
      if (event.fullname.trim().isEmpty) {
        fullNameError = "Please enter your fullname";
      } else if (!GetUtils.isEmail(event.email.trim())) {
        emailError = "Please enter a valid email";
      } else if (event.password.length < 6) {
        passwordError = "Password must be at least of 6 characters";
      }

      if (fullNameError != null ||
          emailError != null ||
          passwordError != null) {
        emit(
          AuthError(
            fullNameError: fullNameError,
            emailError: emailError,
            passwordError: passwordError,
          ),
        );
        return;
      } else {
        emit(AuthLoading());
        try {
          await authRepositories.signup(
            event.fullname,
            event.email,
            event.password,
            event.context,
          );

          emit(Authenticated());
        } catch (e) {
          emit(AuthError(generalError: "Signup failed: $e"));
        } finally {
          FormValidations.fullNameController.clear();
          FormValidations.signUpEmailController.clear();
          FormValidations.signUpPasswordController.clear();
        }
      }
    });
  }
}
