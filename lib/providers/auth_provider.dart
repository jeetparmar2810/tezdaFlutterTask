import 'package:FlutterTask/utils/strings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../utils/pref_keys.dart';

/// Authentication State
class AuthState {
  final User? user;
  final bool isAuthenticated;

  AuthState({this.user, this.isAuthenticated = false});

  AuthState copyWith({User? user, bool? isAuthenticated}) {
    return AuthState(
      user: user ?? this.user,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}

/// Authentication Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState()) {
    _initializeAuthState();
  }

  /// Initialize authentication state on app startup
  Future<void> _initializeAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    final isAuth = prefs.getBool(PrefKeys.isAuthenticated) ?? false;

    if (isAuth) {
      final email = prefs.getString(PrefKeys.userEmail);
      final name = prefs.getString(PrefKeys.userName) ?? '';
      if (email != null) {
        state = AuthState(
          user: User(name: name, email: email),
          isAuthenticated: true,
        );
      }
    }
  }

  /// Save authentication state to SharedPreferences
  Future<void> _saveAuthState(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefKeys.isAuthenticated, true);
    await prefs.setString(PrefKeys.userEmail, email);
    await prefs.setString(PrefKeys.userName, name);
  }

  /// Clear authentication state from SharedPreferences
  Future<void> _clearAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefKeys.isAuthenticated, false);
    await prefs.remove(PrefKeys.userEmail);
    await prefs.remove(PrefKeys.userName);
  }

  /// Register user with name and email
  Future<void> register(String name, String email, String password) async {
    try {
      final user = User(name: name, email: email);
      state = AuthState(user: user, isAuthenticated: true);

      await _saveAuthState(name, email);

      _showDebug(AppStrings.userRegistered);
    } catch (e) {
      _showDebug(AppStrings.registrationFailed);
    }
  }

  /// Log in user
  Future<void> login(String email, String password) async {
    try {
      final user = User(name: "", email: email);
      state = AuthState(user: user, isAuthenticated: true);

      await _saveAuthState(user.name, email);

      _showDebug(AppStrings.userLoggedIn);
    } catch (e) {
      _showDebug(AppStrings.loginFailed);
    }
  }

  /// Log out user
  Future<void> logout() async {
    await _clearAuthState();
    state = AuthState(isAuthenticated: false);
    _showDebug(AppStrings.logoutMessage);
  }

  /// Update user profile data
  Future<void> updateProfile({required String name}) async {
    if (state.user != null) {
      final updatedUser = state.user!.copyWith(name: name);
      state = state.copyWith(user: updatedUser);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(PrefKeys.userName, updatedUser.name);

      _showDebug('User profile updated');
    }
  }

  void _showDebug(String message) {
    print('[AuthNotifier Debug]: $message');
  }
}

/// AuthProvider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
