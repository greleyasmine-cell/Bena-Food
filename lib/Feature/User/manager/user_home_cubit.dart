import 'package:bena_food/Core/Models/restaurant_model.dart';
import 'package:bena_food/Feature/Profile/manager/home_state.dart';
import 'package:bena_food/Feature/User/manager/user_home_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserHomeCubit extends Cubit<UserHomeState>{
  UserHomeCubit() : super(UserHomeState(
      status: UserHomeStatus.initial,
      restaurants: [],
      categories: []));

  Future<void> homeData() async {
    emit(state.copyWith(status: UserHomeStatus.loading));


    FirebaseFirestore.instance
        .collection('restaurants')
        .snapshots()
        .listen((snapshot) {
      final allRestaurants = snapshot.docs.map((doc) {
        return RestaurantModel.fromJson(doc.data(), doc.id);
      }).toList();

      final allCategories = ["All"];
      for (var res in allRestaurants) {
        if (res.category.isNotEmpty && !allCategories.contains(res.category)) {
          allCategories.add(res.category);
        }
      }

      emit(state.copyWith(
        status: UserHomeStatus.success,
        restaurants: allRestaurants,
        categories: allCategories,
      ));
    });
  }

  void changeCategory(String categoryName){
    emit(state.copyWith(selectedCategory: categoryName));
  }
}