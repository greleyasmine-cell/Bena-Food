enum EditProfileStatus { initial, loading, success, failure }

class EditProfileState {
  final EditProfileStatus status;
  final String? errorMessage;

  EditProfileState({
    this.status = EditProfileStatus.initial,
    this.errorMessage,
  });

  EditProfileState copyWith({
    EditProfileStatus? status,
    String? errorMessage,
  }) {
    return EditProfileState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}