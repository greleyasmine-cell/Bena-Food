import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Componants/custom_button.dart';
import 'package:bena_food/Core/Componants/custom_dropdown.dart';
import 'package:bena_food/Core/Componants/custom_textfield.dart';
import 'package:bena_food/Core/Helper/app_data.dart';
import 'package:bena_food/Core/Widget/google_button.dart';
import 'package:bena_food/Core/Widget/orDivider.dart';
import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
   Signup({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final countryController = TextEditingController();
  final wilayaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 25,vertical: 40),
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
                print("Country selected: $country");

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
                print("Wilaya selected: $wilaya");
              },
            ),
            SizedBox(height: 25,),
            CunstomButton(text: "Next", color: AppColors.secondary, textColor: AppColors.primary),
            SizedBox(height: 25),
            orDivider(),
            SizedBox(height: 25,),
            googleButton(),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",style: TextStyle(color: AppColors.white),),
                TextButton(onPressed: (){},
                    child: Text("Log In",style: TextStyle(color: AppColors.secondary,fontWeight: FontWeight.bold),)),
              ],
            )
          ],
        ),
      )
    );
  }
}
