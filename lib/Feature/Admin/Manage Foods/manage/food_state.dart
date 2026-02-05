import 'dart:io';

enum FoodStatus { initial, loading, success, error, addSuccess, deleteSuccess,updateSuccess }
enum GetFoodStatus { initial, loading, success, error }

class FoodState {
  final FoodStatus status;
  final GetFoodStatus getStatus;
  final List<Map<String, dynamic>> foods;
  final String? errorMessage;
  final File? foodImage;
  final String? availability;
  final String? category;
  FoodState({
    this.status = FoodStatus.initial,
    this.getStatus = GetFoodStatus.initial,
    this.foods = const [],
    this.errorMessage,
    this.foodImage,
    this.availability = "Available",
    this.category = "Pizza",
  });

  FoodState copyWith({
    FoodStatus? status,
    GetFoodStatus? getStatus,
    List<Map<String, dynamic>>? foods,
    String? errorMessage,
    File? foodImage,
    String? availability,
    String? category,
  }) {
    return FoodState(
      status: status ?? this.status,
      getStatus: getStatus ?? this.getStatus,
      foods: foods ?? this.foods,
      errorMessage: errorMessage ?? this.errorMessage,
      foodImage: foodImage ?? this.foodImage,
      availability: availability ?? this.availability,
      category: category ?? this.category,
    );
  }
}