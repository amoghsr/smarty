import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthenticationService {
  /* _auth variable simply instantiates the LocalAuthentication
    library, nothing special here. */
  final _auth = LocalAuthentication();

  /*
  bool _isProtectionEnabled keeps track of the respective setting,
  in a real-world app, it should be stored in the shared preferences.
   */
  bool _isProtectionEnabled = false;

  bool get isProtectionEnabled => _isProtectionEnabled;

  set isProtectionEnabled(bool enabled) => _isProtectionEnabled = enabled;

  // isAuthenticated variable will keep track of the authentication
  bool isAuthenticated = false;

  Future<void> authenticate() async {
    if (_isProtectionEnabled) {
      try {
        isAuthenticated = await _auth.authenticateWithBiometrics(
          localizedReason: 'authenticate to access',
          useErrorDialogs: true,
          stickyAuth: true,
        );
      } on PlatformException catch (e) {
        print(e);
      }
    }
  }
}
