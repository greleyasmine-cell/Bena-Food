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

  // --- دالة تسجيل الدخول المعدلة ---
  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));

    // 1. تسجيل الدخول عبر Firebase Auth
    auth.signInWithEmailAndPassword(email: email, password: password).then((value) {

      // 2. جلب بيانات المستخدم من Firestore بعد نجاح الـ Auth
      firestore.collection('users').doc(value.user?.uid).get().then((userDoc) {
        if (userDoc.exists) {
          // استخراج نوع المستخدم (Admin أو User)
          String type = userDoc.get('userType') ?? 'User';
          String name = userDoc.data()?['fullName'] ?? 'Restaurant Owner';
          value.user?.updateDisplayName(name);
          // 3. تحديث الحالة بالنجاح مع نوع المستخدم
          emit(state.copyWith(
            loginStatus: LoginStatus.success,
            userType: type,

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

  // --- دالة التسجيل ---
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
      // حفظ البيانات في Firestore
      await firestore.collection('users').doc(value.user?.uid).set({
        'uid': value.user?.uid,
        'email': email,
        'fullName': firstName,
        'phone': phone,
        'country': country,
        'wilaya': wilaya,
        'userType': selectedType, // تأكدي أن هذا المتغير تم تحديثه قبل نداء register
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