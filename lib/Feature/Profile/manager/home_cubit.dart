import 'package:bena_food/Core/Models/user_model.dart';
import 'package:bena_food/Feature/Profile/manager/home_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());


  void updateSelectedIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }


  Future<void> getProfile() async {
    emit(state.copyWith(getProfileStatus: GetProfileStatus.loading));

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((doc) {
      if (doc.exists && doc.data() != null) {
        emit(
          state.copyWith(
            getProfileStatus: GetProfileStatus.success,
            userModel: UserModel.fromJson(doc.data()!),
          ),
        );
      } else {
        emit(state.copyWith(
          getProfileStatus: GetProfileStatus.failure,
          errorMessage: "User not found",
        ));
      }
    })
        .catchError((error) {
      print("Error fetching profile: $error");
      emit(state.copyWith(
        getProfileStatus: GetProfileStatus.failure,
        errorMessage: error.toString(),
      ));
    });
  }
}