import 'package:bena_food/Feature/User/Food%20List/manager/user_food_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserFoodCubit extends Cubit<UserFoodState>{
  UserFoodCubit(): super(UserFoodState());

  void getRestaurantFoods(String restaurantId, String restaurantName){
    FirebaseFirestore.instance
        .collection('restaurants')
        .doc(restaurantId)
        .collection('foods')
        .snapshots()
        .listen((snapshot){
      List<Map<String, dynamic>> foodsList = [];

      for (var doc in snapshot.docs) {
        var data = doc.data();
        data['id'] = doc.id;
        data['restaurantName'] = restaurantName;
        data['ownerId'] = restaurantId;
        foodsList.add(data);
      }

      emit(state.copyWith(
        status: UserFoodStatus.success,
        foods: foodsList,
      ));
    },onError: (error){
          emit(state.copyWith(
            status: UserFoodStatus.error,
            errorMessage: error.toString(),
          ));
    }
    );
  }
}