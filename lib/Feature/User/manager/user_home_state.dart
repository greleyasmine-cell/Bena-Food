
import 'package:bena_food/Core/Models/restaurant_model.dart';
import 'package:bena_food/Feature/Profile/manager/home_state.dart';

enum UserHomeStatus {initial , loading, success, failure}

class UserHomeState {
  final UserHomeStatus status;
  final List<RestaurantModel> restaurants;
  final List<String> categories;
  final String selectedCategory;

  UserHomeState({
    required this.status,
    required this.restaurants,
    required this.categories,
    this.selectedCategory = "All",
});

  UserHomeState copyWith({
    UserHomeStatus? status,
    List<RestaurantModel>? restaurants,
    List<String>? categories,
    String? selectedCategory,
}){
    return UserHomeState(
        status: status ?? this.status,
        restaurants: restaurants ?? this.restaurants,
        categories: categories ?? this.categories,
        selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}