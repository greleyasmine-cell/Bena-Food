enum EditPasswordStatus { initial , loading, success, failure}

class EditPasswordState{
  final EditPasswordStatus status;
  final String? errorMessage;

  EditPasswordState({this.status = EditPasswordStatus.initial,
  this.errorMessage,
  });

  EditPasswordState copyWith({
    EditPasswordStatus? status,
    String? errorMessage,
}){
    return EditPasswordState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}