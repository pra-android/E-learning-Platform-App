abstract class BiometricAuthEvent {}

class EnableBiometricEvent extends BiometricAuthEvent {}

class DisableBiometricEvent extends BiometricAuthEvent {}

class LoadBiometricEvent extends BiometricAuthEvent {}

class AuthenticateWithBiometric extends BiometricAuthEvent {}
