import 'package:flutter/material.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthUser {
  final String email;

  const AuthUser({required this.email});
}

class AuthProvider extends ChangeNotifier {
  AuthUser? _user;
  AuthStatus _status = AuthStatus.unauthenticated;
  String? _errorMessage;
  bool _isLoading = false;

  AuthUser? get user => _user;
  AuthStatus get status => _status;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _status == AuthStatus.authenticated;

  Future<bool> signInWithEmail(String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      await Future<void>.delayed(const Duration(milliseconds: 350));

      if (!email.contains('@')) {
        _errorMessage = _mapAuthError('invalid-email');
        return false;
      }

      if (password.length < 6) {
        _errorMessage = _mapAuthError('weak-password');
        return false;
      }

      _user = AuthUser(email: email);
      _status = AuthStatus.authenticated;
      return true;
    } finally {
      _setLoading(false);
    }
  }

  void signOut() {
    _user = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }

  String _mapAuthError(String code) {
    switch (code) {
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
