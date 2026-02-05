enum UserFoodStatus { initial, loading, success, error }

class UserFoodState {
  final UserFoodStatus status;
  final List<Map<String, dynamic>> foods;
  final String? errorMessage;

  UserFoodState({
    this.status = UserFoodStatus.initial,
    this.foods = const [],
    this.errorMessage,
  });

  UserFoodState copyWith({
    UserFoodStatus? status,
    List<Map<String, dynamic>>? foods,
    String? errorMessage,
  }) {
    return UserFoodState(
      status: status ?? this.status,
      foods: foods ?? this.foods,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}