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
  void updateType(String type) {
    selectedType = type;
    emit(state.copyWith(userType: type));
  }


  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));


    auth.signInWithEmailAndPassword(email: email, password: password).then((value) {

         firestore.collection('users').doc(value.user?.uid).get().then((userDoc) {
        if (userDoc.exists) {

          String type = userDoc.get('userType') ?? 'User';
          String name = userDoc.data()?['fullName'] ?? 'Restaurant Owner';
          value.user?.updateDisplayName(name);

          emit(state.copyWith(
            loginStatus: LoginStatus.success,
            userType: type,
            userName: name,
          ));
        } else {
          emit(state.copyWith(
            loginStatus: LoginStatus.failure,
            errorMessage: "User data not found in database",
          ));
        }
      }).catchError((error) {
        emit(state.copyWith(
          loginStatus: LoginStatus.failure,
          errorMessage: "Failed to fetch user role",
        ));
      });

    }).catchError((error) {
      if (error is FirebaseAuthException) {
        print("Error Code: ${error.code}");
      }
      emit(state.copyWith(
        loginStatus: LoginStatus.failure,
        errorMessage: error.toString(),
      ));
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

      await value.user?.updateDisplayName(firstName);
      await value.user?.reload();
      await firestore.collection('users').doc(value.user?.uid).set({
        'uid': value.user?.uid,
        'email': email,
        'fullName': firstName,
        'phone': phone,
        'country': country,
        'wilaya': wilaya,
        'userType': selectedType,
      });

      emit(state.copyWith(registerStatus: RegisterStatus.success,
      userType: selectedType,
        userName: firstName,
      ));
    }).catchError((error) {
      print(error);
      emit(state.copyWith(
        registerStatus: RegisterStatus.failure,
        errorMessage: error.toString(),
      ));
    });
  }

  void checkAuthStatus(){
    final user = FirebaseAuth.instance.currentUser;
    if(user != null){
      emit(state.copyWith(authStatus: AuthStatus.authenticated));
    }else{
      emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
    }
  }
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    emit(state.copyWith(authStatus: AuthStatus.unauthenticated));
  }
}