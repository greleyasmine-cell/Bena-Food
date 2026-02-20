import 'dart:io';

enum RegisterStatus { initial, loading, success, failure }
enum LoginStatus { initial, loading, success, failure }
enum AuthStatus { initial, authenticated, unauthenticated }
class AuthState {
  final AuthStatus authStatus;
  final RegisterStatus registerStatus;
  final LoginStatus loginStatus;
  final String? errorMessage;
  final File? profileImage;
  final String? userType;
  final String? userName;

  AuthState({
    this.authStatus = AuthStatus.initial,
    this.registerStatus = RegisterStatus.initial,
    this.loginStatus = LoginStatus.initial,
    this.errorMessage,
    this.profileImage,
    this.userType,
    this.userName,
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    RegisterStatus? registerStatus,
    LoginStatus? loginStatus,
    String? errorMessage,
    File? profileImage,
    String? userType,
    String? userName,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      registerStatus: registerStatus ?? this.registerStatus,
      loginStatus: loginStatus ?? this.loginStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      profileImage: profileImage ?? this.profileImage,
      userType: userType ?? this.userType,
      userName: userName ?? this.userName,
    );
  }
}