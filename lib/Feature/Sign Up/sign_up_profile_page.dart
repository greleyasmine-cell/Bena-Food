import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Componants/custom_button.dart';
import 'package:bena_food/Core/Componants/custom_dropdown.dart';
import 'package:bena_food/Core/Helper/app_data.dart';
import 'package:bena_food/Core/Widget/image_picker.dart';
import 'package:flutter/material.dart';

class SignUpProfilePage extends StatelessWidget {
  const SignUpProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
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

              SizedBox(height: 20,),

              CustomDropdown(hint: "Select User Type",
                  items: AppData.userTypes,
                  onSelected: (selectedType){
                  print("User selected: $selectedType");
                  },
                  prefixIcon: Icons.person_pin_rounded,
                fillColor: AppColors.white,
                iconColor: AppColors.black,
                textColor: AppColors.black,
              ),
              SizedBox(height: 20,),
              CunstomButton(text: "Sign Up", color: AppColors.secondary, textColor: AppColors.primary),


            ],

          ),
        ),
      ),



    );
  }
}
