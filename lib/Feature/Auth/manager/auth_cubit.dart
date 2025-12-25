import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  String? selectedCountry;
  String? selectedWilaya;
  String? selectedType;

  void updateCountry(String country) => selectedCountry = country;
  void updateWilaya(String wilaya) => selectedWilaya = wilaya;
  void updateType(String type) => selectedType = type;

  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));
    auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(state.copyWith(loginStatus: LoginStatus.success));
    })
        .catchError((error) {
      if (error is FirebaseAuthException) {
        print("Error Code: ${error.code}");
        print("Error Message: ${error.message}");
      }
      emit(
        state.copyWith(
          loginStatus: LoginStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    });
  }

  void register({
    required String email,
    required String password,
    required String firstName,
    required String phone,
    required String country,
    required String wilaya,
  }) async {
    emit(state.copyWith(registerStatus: RegisterStatus.loading));

    auth.createUserWithEmailAndPassword(email: email, password: password).then((value) async {

      await firestore.collection('users').doc(value.user?.uid).set({
        'uid': value.user?.uid,
        'email': email,
        'fullName': firstName,
        'phone': phone,
        'country': country,
        'wilaya': wilaya,
        'userType': selectedType,
        //'profileImage': imageUrl,
      });

      emit(state.copyWith(registerStatus: RegisterStatus.success));
    }).catchError((error) {
      print(error);
      emit(state.copyWith(
        registerStatus: RegisterStatus.failure,
        errorMessage: error.toString(),
      ));
    });
  }
}