import 'dart:io';

import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Feature/Admin/Add%20Restaurant/manager/add_restaurant_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddRestaurantCubit extends Cubit<AddRestaurantState>{
  AddRestaurantCubit() : super(AddRestaurantState());

  Future<void> resImage() async{
    final resFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(resFile != null){
      emit(state.copyWith(image: File(resFile.path),status: AddRestaurantStatus.initial));
    }
  }

  void changeStatus(String label){
    emit(state.copyWith(restaurantStatus: label));
  }

  void getRestaurants(){
  final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
  if(currentUserId != null){
    emit(state.copyWith(getStatus: RestaurantStatus.loading));
    FirebaseFirestore.instance
        .collection('restaurants')
        .where('adminId',isEqualTo: currentUserId)
       // .orderBy('createdAt',descending: true)
        .snapshots()
        .listen((snapshot){
      final list = snapshot.docs
         // .where((doc) => doc.data()['createdAt'] != null)
          .map((doc){
        var data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
      emit(state.copyWith(getStatus: RestaurantStatus.success,restaurants: list));
    },onError: (error){
          emit(state.copyWith(getStatus: RestaurantStatus.error));
          print("Firestore Error: $error");
    });
  }
  }

  Future<void> saveRestaurant({
    required String name,
    required String description,
    String? restaurantStatus,
}) async {
    final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if( name.isEmpty){
      emit(state.copyWith(status: AddRestaurantStatus.error,errorMessage: "Missing data!"));
      return;
    }

    emit(state.copyWith(status: AddRestaurantStatus.loading));

   // String imageUrl = "";
  //  if (state.image != null) {
   //   Reference ref = FirebaseStorage.instance.ref().child('restaurants/${DateTime.now()}');
   //   await ref.putFile(state.image!);
 //     imageUrl = await ref.getDownloadURL();
 //   }
    await FirebaseFirestore.instance.collection('restaurants').add({
      'name': name,
      'description': description,
      'status':restaurantStatus,
      'adminId' :currentUserId,
      //'image':imageUrl,
      'createdAt':FieldValue.serverTimestamp(),
    });
    emit(state.copyWith(status: AddRestaurantStatus.success));
    emit(state.copyWith(image: null,restaurantStatus: "Open",status: AddRestaurantStatus.initial));
  }


  void deleteRestaurant(String id) async {
    await FirebaseFirestore.instance.collection('restaurants').doc(id).delete();
    Fluttertoast.showToast(msg: "Deleted!",
      backgroundColor: Colors.green,
      textColor: AppColors.white,
      gravity: ToastGravity.TOP,
    );
  }

  Future<void> updateRestaurant({
    required String restarantId,
    required String name,
    required String description,
    required String restaurantStatus,
})async{
    emit(state.copyWith(status: AddRestaurantStatus.loading));

    await FirebaseFirestore.instance
        .collection('restaurants')
    .doc(restarantId)
    .update({
      'name':name,
      'description': description,
      'status': restaurantStatus,
      'updatedAt': FieldValue.serverTimestamp(),
    });

    emit(state.copyWith(status: AddRestaurantStatus.updateSuccess));

    emit(state.copyWith(status: AddRestaurantStatus.initial));
  }


}