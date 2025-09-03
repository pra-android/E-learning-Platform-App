abstract class BiometricAuthState {}

class BiometricInitial extends BiometricAuthState {}

class BiometricSettingLoaded extends BiometricAuthState {
  final bool enabled;
  BiometricSettingLoaded(this.enabled);
}

class BiometricAuthenticated extends BiometricAuthState {}

class BiometricError extends BiometricAuthState {
  final String message;
  BiometricError(this.message);
}
