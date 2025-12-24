import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Componants/custom_button.dart';
import 'package:bena_food/Core/Componants/custom_dropdown.dart';
import 'package:bena_food/Core/Componants/custom_textfield.dart';
import 'package:bena_food/Core/Helper/app_data.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
   EditProfile({super.key});
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final countryController = TextEditingController();
  final wilayaController = TextEditingController();
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
              Text("Edit Profile",
                style: TextStyle(color: AppColors.primary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),),
              SizedBox(height: 30,),
              CustomTextfield(
                hint: "Full Name",
                controller: nameController,
                prefixIcon: Icons.person,
                textColor: AppColors.white,
                fillColor: AppColors.primary,
                iconsColor: AppColors.white,
              ),
              SizedBox(height: 20,),
              CustomTextfield(
                hint: "Email",
                controller: emailController,
                prefixIcon: Icons.email,
                textColor: AppColors.white,
                fillColor: AppColors.primary,
                iconsColor: AppColors.white,
              ),
              SizedBox(height: 20,),
              CustomTextfield(
                hint: "Phone Number",
                controller: phoneController,
                prefixIcon: Icons.phone,
                textColor: AppColors.white,
                fillColor: AppColors.primary,
                iconsColor: AppColors.white,
              ),
              SizedBox(height: 20,),
              CustomDropdown(
                textColor: AppColors.white,
                fillColor: AppColors.primary,
                iconColor: AppColors.white,
                hint: "Country",
                prefixIcon: Icons.public,
                items: AppData.countries,
                onSelected: (country) {
                  print("Country selected: $country");

                },
              ),
              SizedBox(height: 20,),
              CustomDropdown(
                textColor: AppColors.white,
                fillColor: AppColors.primary,
                iconColor: AppColors.white,
                hint: "Wilaya",
                prefixIcon: Icons.location_city,
                items: AppData.algerianWilayas,
                onSelected: (wilaya) {
                  print("Wilaya selected: $wilaya");
                },
              ),
              SizedBox(height: 25,),
              CunstomButton(text: "Save", color: AppColors.secondary, textColor: AppColors.primary,),
              SizedBox(height: 25),
              CunstomButton(text: "Cancel", color: AppColors.secondary, textColor: AppColors.black),
            ],
          ),
        ),
      ),
    );
  }
}
