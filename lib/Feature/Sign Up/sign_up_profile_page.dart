import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Componants/custom_button.dart';
import 'package:bena_food/Core/Componants/custom_dropdown.dart';
import 'package:bena_food/Core/Componants/custom_textfield.dart';
import 'package:bena_food/Core/Helper/app_data.dart';
import 'package:bena_food/Core/Widget/image_picker.dart';
import 'package:bena_food/Feature/Auth/manager/auth_cubit.dart';
import 'package:bena_food/Feature/Auth/manager/auth_state.dart';
import 'package:bena_food/Feature/Profile/profile_user/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpProfilePage extends StatelessWidget {
  final String fullName;
  final String email;
  final String phone;
  final String country;
  final String wilaya;
  SignUpProfilePage({super.key,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.country,
    required this.wilaya,
  });
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
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
                  Text("Sign Up",
                    style: TextStyle(color: AppColors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),),
                  SizedBox(height: 30,),
        
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: AppColors.white,
                        child: Icon(Icons.person,size: 80,
                        color: AppColors.primary,
                        ),
                        //backgroundImage: state.image != null ? FileImage(state.image!),
                      ),
                      ImagePickerSheet(),
                    ],
                  ),
                  SizedBox(height: 30,),
                  CustomTextfield(hint: "Password",
                  controller: passwordController,
                    prefixIcon: Icons.lock,
                    fillColor: AppColors.white,
                    textColor: AppColors.black,
                    iconsColor: AppColors.black,
                    obscureText: true,
                    isPassword: true,
                    validator: (value){
                    if(value == null || value.length < 3){
                      return "Password must be at least 3 characters";
                    }
                    return null;
                    },
                  ),
        
                  SizedBox(height: 20,),
        
                  CustomDropdown(hint: "Select User Type",
                      items: AppData.userTypes,
                      onSelected: (selectedType){
                     // print("User selected: $selectedType");
                        context.read<AuthCubit>().updateType(selectedType!);
                      },
                      prefixIcon: Icons.person_pin_rounded,
                    fillColor: AppColors.white,
                    iconColor: AppColors.black,
                    textColor: AppColors.black,
                  ),
                  SizedBox(height: 20,),
                  BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if(state.registerStatus == RegisterStatus.success){
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) => UserProfilePage()),
                  (route) => false,);
            }else if(state.registerStatus == RegisterStatus.failure){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage ?? "Error during Sign Up")),
              );
            }
          },
          builder: (context, state) {
            if(state.registerStatus == RegisterStatus.loading){
              return CircularProgressIndicator(color: AppColors.white,);
            }
            return CunstomButton(text: "Sign Up",
                color: AppColors.secondary,
                textColor: AppColors.primary,
            onPressed: (){
              if(formKey.currentState!.validate()){
                context.read<AuthCubit>().register(email: email, password: passwordController.text, firstName: fullName, phone: phone, country: country, wilaya: wilaya);
              }
            },);
          },
        ),
        
        
                ],
        
              ),
            ),
          ),
        ),
      ),



    );
  }
}
