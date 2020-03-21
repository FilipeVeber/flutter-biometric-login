import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuthentication {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<bool> authenticateUser() async {
    bool authenticated = false;

    if (await _isBiometricAvailable()) {
      await _getBiometricTypes();
      authenticated = await _authenticateUser();
    }

    return authenticated;
  }

  Future<bool> _isBiometricAvailable() async {
    bool isAvailable = false;
    try {
      isAvailable = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    isAvailable
        ? print("Biometric is available")
        : print("Biometric is not available");

    return isAvailable;
  }

  Future<void> _getBiometricTypes() async {
    List<BiometricType> biometrics;
    try {
      biometrics = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    print(biometrics);
  }

  Future<bool> _authenticateUser() async {
    bool isAuthenticated = false;

    try {
      isAuthenticated = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Please authenticate to login",
        useErrorDialogs: true,
        stickyAuth: true,
      );

      isAuthenticated
          ? print('User is authenticated!')
          : print('User is not authenticated.');

      return isAuthenticated;
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
