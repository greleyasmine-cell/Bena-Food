enum RegisterStatus{initial, loading, success, failure}
enum LoginStatus{initial, loading, success, failure}

class AuthState {
  final RegisterStatus registerStatus;
  final LoginStatus loginStatus;
  final String? errorMessage;

  AuthState({
    this.registerStatus = RegisterStatus.initial,
    this.loginStatus = LoginStatus.initial,
    this.errorMessage,
});

  AuthState copyWith({
    RegisterStatus? registerStatus,
    LoginStatus? loginStatus,
    String? errorMessage,
}){
    return AuthState(
      registerStatus: registerStatus ?? this.registerStatus,
      loginStatus: loginStatus ?? this.loginStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}