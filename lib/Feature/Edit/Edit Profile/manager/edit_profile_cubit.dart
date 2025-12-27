import 'package:bena_food/Feature/Edit/Edit%20Profile/manager/edit_profile_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileState());

  Future<void> updateUserData({
    required String fullName,
    required String email,
    required String phone,
    required String country,
    required String wilaya,
  }) async {
    emit(state.copyWith(status: EditProfileStatus.loading));

    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;

      if (uid != null) {

        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'fullName': fullName,
          'email': email,
          'phone': phone,
          'country': country,
          'wilaya': wilaya,
        });

        emit(state.copyWith(status: EditProfileStatus.success));
      } else {
        throw Exception("No registered user found");
      }
    } catch (e) {
      emit(state.copyWith(
        status: EditProfileStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}