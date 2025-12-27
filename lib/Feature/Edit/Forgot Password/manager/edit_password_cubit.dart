

import 'package:bena_food/Feature/Edit/Forgot%20Password/manager/edit_password_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPasswordCubit extends Cubit<EditPasswordState> {
  EditPasswordCubit() : super(EditPasswordState());

  Future<void> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
})async{
    emit(state.copyWith(status:  EditPasswordStatus.loading));
    User? user = FirebaseAuth.instance.currentUser;

    AuthCredential credential = EmailAuthProvider.credential(email: email, password: currentPassword);

    await user!.reauthenticateWithCredential(credential);
    await user.updatePassword(newPassword);

    emit(EditPasswordState(status: EditPasswordStatus.success));
  }
}