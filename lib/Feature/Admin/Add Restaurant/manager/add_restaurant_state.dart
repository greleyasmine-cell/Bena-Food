import 'dart:io';

enum AddRestaurantStatus {initial, loading, success, error,updateSuccess}
enum RestaurantStatus {initial,loading,success,error}

class AddRestaurantState {
  final AddRestaurantStatus status;
  final RestaurantStatus getStatus;
  final List<Map<String,dynamic>> restaurants;
  final String? errorMessage;
  final File? image;
  final String? restaurantStatus;
  final String? adminId;

  AddRestaurantState({
    this.status = AddRestaurantStatus.initial,
    this.getStatus = RestaurantStatus.initial,
    this.restaurants = const [],
    this.errorMessage,
    this.image,
    this.restaurantStatus = "Open",
    this.adminId,
});

  AddRestaurantState copyWith({
    AddRestaurantStatus? status,
    RestaurantStatus? getStatus,
    List<Map<String,dynamic>>? restaurants,
    String? errorMessage,
    File? image,
    String? restaurantStatus,
    String? adminId,
}){
    return AddRestaurantState(
      status:  status ?? this.status,
      getStatus: getStatus ?? this.getStatus,
      restaurants: restaurants ?? this.restaurants,
      errorMessage:  errorMessage ?? this.errorMessage,
      image: image ?? this.image,
      restaurantStatus: restaurantStatus ?? this.restaurantStatus,
      adminId:  adminId ?? this.adminId,
    );
  }
}