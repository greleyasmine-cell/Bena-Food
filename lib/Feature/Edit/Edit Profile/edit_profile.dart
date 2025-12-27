import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Componants/custom_button.dart';
import 'package:bena_food/Core/Componants/custom_dropdown.dart';
import 'package:bena_food/Core/Componants/custom_textfield.dart';
import 'package:bena_food/Core/Helper/app_data.dart';
import 'package:bena_food/Feature/Edit/Edit%20Profile/manager/edit_profile_cubit.dart';
import 'package:bena_food/Feature/Edit/Edit%20Profile/manager/edit_profile_state.dart';
import 'package:bena_food/Feature/Profile/profile_user/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfile extends StatelessWidget {
  final String name,email,phone,country,wilaya;
  EditProfile({super.key,
  required this.name,
    required this.email,
    required this.phone,
    required this.country,
    required this.wilaya,
  });

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: name);
    final emailController = TextEditingController(text: email);
    final phoneController = TextEditingController(text: phone);
    String selectedCountry = country;
    String selectedWilaya = wilaya;
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
                "Edit Profile",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              CustomTextfield(
                hint: "Full Name",
                controller: nameController,
                prefixIcon: Icons.person,
                textColor: AppColors.white,
                fillColor: AppColors.primary,
                iconsColor: AppColors.white,
              ),
              SizedBox(height: 20),
              CustomTextfield(
                hint: "Email",
                controller: emailController,
                prefixIcon: Icons.email,
                textColor: AppColors.white,
                fillColor: AppColors.primary,
                iconsColor: AppColors.white,
              ),
              SizedBox(height: 20),
              CustomTextfield(
                hint: "Phone Number",
                controller: phoneController,
                prefixIcon: Icons.phone,
                textColor: AppColors.white,
                fillColor: AppColors.primary,
                iconsColor: AppColors.white,
              ),
              SizedBox(height: 20),
              CustomDropdown(
                textColor: AppColors.white,
                fillColor: AppColors.primary,
                iconColor: AppColors.white,
                hint: country.isEmpty ? "Select Country" : country,
                prefixIcon: Icons.public,
                items: AppData.countries,
                onSelected: (val) {
                  //   print("Country selected: $country");
                  selectedCountry = val ?? country;
                },
              ),
              SizedBox(height: 20),
              CustomDropdown(
                textColor: AppColors.white,
                fillColor: AppColors.primary,
                iconColor: AppColors.white,
                hint: wilaya.isEmpty ? "Select Wilaya" : wilaya,
                prefixIcon: Icons.location_city,
                items: AppData.algerianWilayas,
                onSelected: (val) {
                  //  print("Wilaya selected: $wilaya");
                  selectedWilaya = val ?? wilaya;
                },
              ),
              SizedBox(height: 25),
              BlocConsumer<EditProfileCubit, EditProfileState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if(state.status == EditProfileStatus.success){
                    Fluttertoast.showToast(msg: "Profile Updated Successfully!",
                    backgroundColor: Colors.green,
                      textColor: AppColors.white,
                    );
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) => UserProfilePage()),
                        (route)=> false);
                  }else if(state.status == EditProfileStatus.failure){
                    Fluttertoast.showToast(msg: "Failed to update Profile",
                    backgroundColor: Colors.red,
                      textColor: AppColors.white,
                    );
                  }
                },
                builder: (context, state) {
                  if(state.status == EditProfileStatus.loading){
                    return CircularProgressIndicator(color: AppColors.primary,);
                  }
                  return CunstomButton(
                    text: "Save",
                    color: AppColors.secondary,
                    textColor: AppColors.primary,
                    onPressed: (){
                      context.read<EditProfileCubit>().updateUserData(
                          fullName: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                          country: selectedCountry ,
                          wilaya: selectedWilaya ,
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 25),
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
