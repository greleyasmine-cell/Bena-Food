import 'package:bena_food/Core/Models/user_model.dart';

enum GetProfileStatus { initial, loading, success, failure }

class HomeState {
  final GetProfileStatus getProfileStatus;
  final int selectedIndex;
  final UserModel? userModel;
  final String? errorMessage;

  HomeState({
    this.getProfileStatus = GetProfileStatus.initial,
    this.selectedIndex = 0,
    this.userModel,
    this.errorMessage,
  });

  HomeState copyWith({
    GetProfileStatus? getProfileStatus,
    int? selectedIndex,
    UserModel? userModel,
    String? errorMessage,
  }) {
    return HomeState(
      getProfileStatus: getProfileStatus ?? this.getProfileStatus,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      userModel: userModel ?? this.userModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}