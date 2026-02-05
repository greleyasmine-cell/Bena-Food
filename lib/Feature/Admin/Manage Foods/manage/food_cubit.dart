import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'food_state.dart';

class FoodCubit extends Cubit<FoodState> {
  FoodCubit() : super(FoodState());

  final ImagePicker _picker = ImagePicker();


  Future<void> pickFoodImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(state.copyWith(foodImage: File(pickedFile.path)));
    }
  }

  void addFood({
    required String restaurantId,
    required String name,
    required String price,
    required String description,
  }) {
    emit(state.copyWith(status: FoodStatus.loading));

    FirebaseFirestore.instance
        .collection('restaurants')
        .doc(restaurantId)
        .collection('foods')
        .add({
      'name': name,
      'price': price,
      'description': description,
      'status': state.availability,
      'category': state.category,
      //'image': "",
      'createdAt': DateTime.now(),
    }).then((value) {

      emit(state.copyWith(status: FoodStatus.addSuccess, foodImage: null));
    });
  }


  void getFoods(String restaurantId) {
    emit(state.copyWith(getStatus: GetFoodStatus.loading));

    FirebaseFirestore.instance
        .collection('restaurants')
        .doc(restaurantId)
        .collection('foods')
        .snapshots()
        .listen((snapshot) {
      List<Map<String, dynamic>> foodsList = [];
      for (var doc in snapshot.docs) {
        var data = doc.data();
        data['id'] = doc.id;
        foodsList.add(data);
      }
      emit(state.copyWith(getStatus: GetFoodStatus.success, foods: foodsList));
    });
  }

  void changeCategory(String value) {
    emit(state.copyWith(category: value));
  }
  void changeAvailability(String value) {
    emit(state.copyWith(availability: value));
  }


  void deleteFood({required String restaurantId, required String foodId}) {

    FirebaseFirestore.instance
        .collection('restaurants')
        .doc(restaurantId)
        .collection('foods')
        .doc(foodId)
        .delete()
        .then((value) {

      emit(state.copyWith(status: FoodStatus.deleteSuccess));
    });

  }

  void updateFood({
    required String restaurantId,
    required String foodId,
    required String name,
    required String price,
    required String description,
  }) {
    emit(state.copyWith(status: FoodStatus.loading));

    FirebaseFirestore.instance
        .collection('restaurants')
        .doc(restaurantId)
        .collection('foods')
        .doc(foodId)
        .update({
      'name': name,
      'price': price,
      'description': description,
      'category': state.category,
      'status': state.availability,
      // 'image': state.imagePath ?? currentImagePath,
      'updatedAt': DateTime.now(),
    }).then((value) {
      emit(state.copyWith(status: FoodStatus.updateSuccess));
    });
  }
}