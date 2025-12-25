import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Componants/custom_button.dart';
import 'package:bena_food/Core/Componants/custom_dropdown.dart';
import 'package:bena_food/Core/Componants/custom_textfield.dart';
import 'package:bena_food/Core/Helper/app_data.dart';
import 'package:bena_food/Core/Widget/google_button.dart';
import 'package:bena_food/Core/Widget/orDivider.dart';
import 'package:bena_food/Feature/Auth/login_page.dart';
import 'package:bena_food/Feature/Auth/manager/auth_cubit.dart';
import 'package:bena_food/Feature/Sign%20Up/sign_up_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signup extends StatelessWidget {
   Signup({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final countryController = TextEditingController();
  final wilayaController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 25,vertical: 40),
        child: Form(
          key: formKey,
          child: Column(
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

              CustomTextfield(
                  hint: "Full Name",
                  controller: nameController,
                prefixIcon: Icons.person,
                textColor: AppColors.black,
                fillColor: AppColors.white,

              ),
              SizedBox(height: 20,),
              CustomTextfield(
                hint: "Email",
                controller: emailController,
                prefixIcon: Icons.email,
                textColor: AppColors.black,
                fillColor: AppColors.white,
              ),
              SizedBox(height: 20,),
              CustomTextfield(
                hint: "Phone Number",
                controller: phoneController,
                prefixIcon: Icons.phone,
                textColor: AppColors.black,
                fillColor: AppColors.white,
              ),
              SizedBox(height: 20,),
              CustomDropdown(
                fillColor: AppColors.white,
                iconColor: AppColors.black,
                textColor: AppColors.black,
                hint: "Country",
                prefixIcon: Icons.public,
                items: AppData.countries,
                onSelected: (country) {
                 // print("Country selected: $country");
                 context.read<AuthCubit>().updateCountry(country!);
                },
              ),
              SizedBox(height: 20,),
              CustomDropdown(
                fillColor: AppColors.white,
                iconColor: AppColors.black,
                textColor: AppColors.black,
                hint: "Wilaya",
                prefixIcon: Icons.location_city,
                items: AppData.algerianWilayas,
                onSelected: (wilaya) {
                 // print("Wilaya selected: $wilaya");
                  context.read<AuthCubit>().updateWilaya(wilaya!);
                },
              ),
              SizedBox(height: 25,),
              CunstomButton(text: "Next",
                  color: AppColors.secondary,
                  textColor: AppColors.primary,
                  onPressed: (){
                if(formKey.currentState!.validate()){
                  var authCubit = context.read<AuthCubit>();
                  if(authCubit.selectedCountry != null && authCubit.selectedWilaya != null){
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpProfilePage(
                      fullName: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      country: authCubit.selectedCountry!,
                      wilaya: authCubit.selectedWilaya!,
                    ))
                    );
                  }
                }
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
                  Text("Already have an account?",style: TextStyle(color: AppColors.white),),
                  TextButton(onPressed: (){

                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                            (route) => false);
                  },
                      child: Text("Log In",style: TextStyle(color: AppColors.secondary,fontWeight: FontWeight.bold),)),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
