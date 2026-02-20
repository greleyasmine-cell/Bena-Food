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
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      emit(state.copyWith(
        getProfileStatus: GetProfileStatus.failure,
        errorMessage: "No authenticated user found",
      ));
      return;
    }


    emit(state.copyWith(getProfileStatus: GetProfileStatus.loading));

    try {

      final DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get()
          .timeout(const Duration(seconds: 15));

      if (doc.exists && doc.data() != null) {

        final userModel = UserModel.fromJson(doc.data()!);

        emit(state.copyWith(
          getProfileStatus: GetProfileStatus.success,
          userModel: userModel,
        ));
      } else {

        emit(state.copyWith(
          getProfileStatus: GetProfileStatus.failure,
          errorMessage: "User document does not exist in Firestore",
        ));
      }
    } on FirebaseException catch (e) {
      print("Firestore Error: ${e.code} - ${e.message}");
      emit(state.copyWith(
        getProfileStatus: GetProfileStatus.failure,
        errorMessage: "Firebase Error: ${e.message}",
      ));
    } catch (error) {

      print("Error fetching profile: $error");
      emit(state.copyWith(
        getProfileStatus: GetProfileStatus.failure,
        errorMessage: "Firebase Error: ${error.toString()}",
      ));
    }
  }
}