import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Componants/custom_button.dart';
import 'package:bena_food/Core/Componants/custom_textfield.dart';
import 'package:bena_food/Feature/Edit/Forgot%20Password/manager/edit_password_cubit.dart';
import 'package:bena_food/Feature/Edit/Forgot%20Password/manager/edit_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final emailController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo/bena_food.png", width: 250),
              Text(
                "Forgot Password",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              CustomTextfield(
                hint: "Email",
                iconsColor: AppColors.white,
                fillColor: AppColors.primary,
                textColor: AppColors.white,
                controller: emailController,
                prefixIcon: Icons.email_rounded,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'null';
                  }
                  if (!value.contains('@')) {
                    return "Check your Email!!";
                  } else
                    return 'Enter your Email';
                },
              ),
              SizedBox(height: 20),
              CustomTextfield(
                hint: "Current Password",
                controller: currentPasswordController,
                prefixIcon: Icons.lock,
                iconsColor: AppColors.white,
                fillColor: AppColors.primary,
                textColor: AppColors.white,
                obscureText: true,
                isPassword: true,
                validator: (value) {
                  if ((value?.length ?? 0) < 3) {
                    return "Please Enter more 3 Car";
                  } else
                    return "Enter your password";
                },
              ),
              SizedBox(height: 20),

              CustomTextfield(
                hint: "New Password",
                controller: newPasswordController,
                prefixIcon: Icons.lock,
                iconsColor: AppColors.white,
                fillColor: AppColors.primary,
                textColor: AppColors.white,
                obscureText: true,
                isPassword: true,
                validator: (value) {
                  if ((value?.length ?? 0) < 3) {
                    return "Please Enter more 3 Car";
                  } else
                    return "Enter your password";
                },
              ),
              SizedBox(height: 20),

              CustomTextfield(
                hint: "Confirm New Password",
                controller: confirmPasswordController,
                prefixIcon: Icons.lock,
                iconsColor: AppColors.white,
                fillColor: AppColors.primary,
                textColor: AppColors.white,
                obscureText: true,
                isPassword: true,
                validator: (value) {
                  if ((value?.length ?? 0) < 3) {
                    return "Please Enter more 3 Car";
                  } else
                    return "Enter your password";
                },
              ),
              SizedBox(height: 20),
              BlocConsumer<EditPasswordCubit, EditPasswordState>(
                listener: (context, state) {
                  // TODO: implement listener
                      if(state.status == EditPasswordStatus.success){
                        Fluttertoast.showToast(msg: "The password has been successfully changed!",
                        backgroundColor: Colors.green,
                          textColor: AppColors.white,
                          gravity: ToastGravity.BOTTOM,
                        );
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) => ForgotPassword()),
                            (route) => false);
                      }else if(state.status == EditPasswordStatus.failure){
                        Fluttertoast.showToast(msg: "The process failed, please check your data",
                        backgroundColor: Colors.red,
                          textColor: AppColors.white,
                        );
                      }
                },
                builder: (context, state) {
                  if(state.status == EditPasswordStatus.loading){
                    return CircularProgressIndicator(color: AppColors.primary,);
                  }
                  return CunstomButton(
                    text: "Change Password",
                    color: AppColors.secondary,
                    textColor: AppColors.primary,
                    onPressed: (){
                      if(newPasswordController.text != confirmPasswordController.text){
                        Fluttertoast.showToast(msg: "The new passwords do not match",
                        backgroundColor: AppColors.primary,
                          textColor: AppColors.white,
                        );
                        return;
                      }
                      context.read<EditPasswordCubit>().changePassword(
                           email: emailController.text,
                           currentPassword : currentPasswordController.text,
                           newPassword: newPasswordController.text,
                      );

                    },

                  );
                },
              ),
              SizedBox(height: 20),
              CunstomButton(
                text: "Cancel",
                color: AppColors.secondary,
                textColor: AppColors.black,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
