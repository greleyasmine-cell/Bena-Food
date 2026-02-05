import 'dart:io';

enum RegisterStatus { initial, loading, success, failure }
enum LoginStatus { initial, loading, success, failure }

class AuthState {
  final RegisterStatus registerStatus;
  final LoginStatus loginStatus;
  final String? errorMessage;
  final File? profileImage;
  final String? userType;

  AuthState({
    this.registerStatus = RegisterStatus.initial,
    this.loginStatus = LoginStatus.initial,
    this.errorMessage,
    this.profileImage,
    this.userType,
  });

  AuthState copyWith({
    RegisterStatus? registerStatus,
    LoginStatus? loginStatus,
    String? errorMessage,
    File? profileImage,
    String? userType,
  }) {
    return AuthState(
      registerStatus: registerStatus ?? this.registerStatus,
      loginStatus: loginStatus ?? this.loginStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      profileImage: profileImage ?? this.profileImage,
      userType: userType ?? this.userType,
    );
  }
}