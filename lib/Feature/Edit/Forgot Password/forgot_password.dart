import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Componants/custom_button.dart';
import 'package:bena_food/Core/Componants/custom_textfield.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
   ForgotPassword({super.key});
  final emailController = TextEditingController();
  final passwordController= TextEditingController();
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
              Image.asset(
                "assets/logo/bena_food.png",
                width: 250,
              ),
              Text("Forgot Password",
                style: TextStyle(color: AppColors.primary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),),
              SizedBox(height: 30,),
              CustomTextfield(
                hint: "Email",
                iconsColor: AppColors.white,
                fillColor: AppColors.primary,
                textColor: AppColors.white,
                controller: emailController,
                prefixIcon: Icons.email_rounded,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'null';
                  }
                  if(!value.contains('@')){
                    return "Check your Email!!";
                  }else return 'Enter your Email';
                },
              ),
              SizedBox(height: 20,),
              CustomTextfield(hint: "Current Password",
                controller: passwordController,
                prefixIcon: Icons.lock,
                iconsColor: AppColors.white,
                fillColor: AppColors.primary,
                textColor: AppColors.white,
                obscureText: true,
                isPassword: true,
                validator: (value){
                  if((value?.length??0) < 3){
                    return "Please Enter more 3 Car";
                  }else return "Enter your password";
                },
              ),
              SizedBox(height: 20,),

              CustomTextfield(hint: "New Password",
                controller: passwordController,
                prefixIcon: Icons.lock,
                iconsColor: AppColors.white,
                fillColor: AppColors.primary,
                textColor: AppColors.white,
                obscureText: true,
                isPassword: true,
                validator: (value){
                  if((value?.length??0) < 3){
                    return "Please Enter more 3 Car";
                  }else return "Enter your password";
                },
              ),
              SizedBox(height: 20,),

              CustomTextfield(hint: "Confirm New Password",
                controller: passwordController,
                prefixIcon: Icons.lock,
                iconsColor: AppColors.white,
                fillColor: AppColors.primary,
                textColor: AppColors.white,
                obscureText: true,
                isPassword: true,
                validator: (value){
                  if((value?.length??0) < 3){
                    return "Please Enter more 3 Car";
                  }else return "Enter your password";
                },
              ),
              SizedBox(height: 20,),
              CunstomButton(text: "Change Password", color: AppColors.secondary, textColor: AppColors.primary),
              SizedBox(height: 20,),
              CunstomButton(text: "Cancel", color: AppColors.secondary, textColor: AppColors.black),
            ],
          ),
        ),
      ),
    );
  }
}
