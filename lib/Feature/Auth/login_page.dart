import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Componants/custom_button.dart';
import 'package:bena_food/Core/Componants/custom_textfield.dart';
import 'package:bena_food/Core/Widget/google_button.dart';
import 'package:bena_food/Core/Widget/orDivider.dart';
import 'package:bena_food/Feature/Auth/manager/auth_cubit.dart';
import 'package:bena_food/Feature/Auth/manager/auth_state.dart';
import 'package:bena_food/Feature/Edit/Forgot%20Password/forgot_password.dart';
import 'package:bena_food/Feature/Profile/profile_user/user_profile_page.dart';
import 'package:bena_food/Feature/Sign%20Up/signUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});
  final emailController = TextEditingController();
  final passwordController= TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Image.asset(
                  "assets/logo/benabena.png",
                  width: 150,
                  height: 150,
                ),
              Text("Log In",style: TextStyle(color: AppColors.white,fontSize: 28,fontWeight: FontWeight.bold),),
              SizedBox(height: 40,),
              CustomTextfield(
                  hint: "Email",
                  fillColor: AppColors.white,
                  textColor: AppColors.black,
                  controller: emailController,
                  prefixIcon: Icons.email_rounded,
                validator: (value){
                    if(value == null || value.isEmpty){
                      return 'null';
                    }
                    if(!value.contains('@')){
                      return "Check your Email!!";
                    }else return null;
                },

              ),
              SizedBox(height: 20,),
              CustomTextfield(hint: "Password",
                  controller: passwordController,
              prefixIcon: Icons.lock,
              fillColor: AppColors.white,
              textColor: AppColors.black,
              obscureText: true,
                isPassword: true,
                validator: (value){
                if((value?.length??0) < 3){
                  return "Please Enter more 3 Car";
                }else return null;
                },
              ),
              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Row(
                   children: [
                     Icon(Icons.check_box_outline_blank,color: AppColors.white,size: 20,),
                     Text("Remember me",style: TextStyle(color: AppColors.white),),
                   ],
                 ),
                  TextButton(onPressed: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context)=>ForgotPassword() ));
                  },
                      child: Text("Forgot Password?",style: TextStyle(color: AppColors.secondary),))
                ],
              ),

              SizedBox(height: 10,),
              BlocConsumer<AuthCubit, AuthState>(
  listener: (context, state) {
    if(state.loginStatus == LoginStatus.failure){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.errorMessage ?? "Login Failed"),
        ),
      );

    }else if(state.loginStatus == LoginStatus.success){
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => UserProfilePage()),
          (route) => false);
    }
  },
  builder: (context, state) {
    if (state.loginStatus == LoginStatus.loading){
      return CircularProgressIndicator(color: AppColors.white,);
    }
    return CunstomButton(text: "Log In",
                  color: AppColors.secondary,
                  textColor: AppColors.primary,
                  onPressed: (){

                  context.read<AuthCubit>().login(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  },
              );
  },
),
              SizedBox(height: 25),
              orDivider(),
              SizedBox(height: 25,),
              googleButton(),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",style: TextStyle(color: AppColors.white),),
                  TextButton(onPressed: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context)=>Signup() ));
                  },
                      child: Text("Sign Up",style: TextStyle(color: AppColors.secondary,fontWeight: FontWeight.bold),)),
                ],
              )
            ],
          ),
        ),
      )

    );
  }
}
