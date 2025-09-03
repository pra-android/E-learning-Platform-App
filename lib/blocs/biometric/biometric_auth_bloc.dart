import 'package:e_learning_platform/blocs/biometric/biometric_auth_event.dart';
import 'package:e_learning_platform/blocs/biometric/biometric_auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart'
    show LocalAuthentication, AuthenticationOptions;
import 'package:shared_preferences/shared_preferences.dart';

class BiometricAuthBloc extends Bloc<BiometricAuthEvent, BiometricAuthState> {
  final LocalAuthentication _localAuth = LocalAuthentication();

  BiometricAuthBloc() : super(BiometricInitial()) {
    on<LoadBiometricEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final enabled = prefs.getBool('biometric_enabled') ?? false;
      emit(BiometricSettingLoaded(enabled));
    });
    on<EnableBiometricEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('biometric_enabled', true);
      emit(BiometricSettingLoaded(true));
    });

    on<DisableBiometricEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('biometric_enabled', false);
      emit(BiometricSettingLoaded(false));
    });
    on<AuthenticateWithBiometric>((event, emit) async {
      try {
        bool canCheck = await _localAuth.canCheckBiometrics;
        debugPrint("Can check is $canCheck");
        if (!canCheck) {
          emit(BiometricError("Biometric not available"));
        } else {
          bool didAuthenticate = await _localAuth.authenticate(
            localizedReason: 'Please authenticate to login',
            options: const AuthenticationOptions(biometricOnly: true),
          );
          if (didAuthenticate) {
            emit(BiometricAuthenticated());
          } else {
            emit(BiometricError("Authentication failed"));
          }
        }
      } catch (e) {
        emit(BiometricError(e.toString()));
      }
    });
  }
}
