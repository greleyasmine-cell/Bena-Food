import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Componants/custom_button.dart';
import 'package:bena_food/Core/Widget/info_user.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

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
                Text("Profile",
                  style: TextStyle(color: AppColors.primary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.primary,
                      child: Icon(Icons.person,size: 60,
                        color: AppColors.white,
                      ),
                      //backgroundImage: state.image != null ? FileImage(state.image!),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                InfoUser(
                    icon: Icons.person,
                    label: "Full Name",
                ),
                SizedBox(height: 15,),
                InfoUser(
                  icon: Icons.email_rounded,
                  label: "Email",
                ),
                SizedBox(height: 15,),
                InfoUser(
                  icon: Icons.phone,
                  label: "Phone Number",
                ),
                SizedBox(height: 15,),
                InfoUser(
                  icon: Icons.public,
                  label: "Country",
                ),
                SizedBox(height: 15,),
                InfoUser(
                  icon: Icons.location_city_rounded,
                  label: "Wilaya",
                ),
                SizedBox(height: 20,),
                CunstomButton(text: "Edit Profile", color: AppColors.primary, textColor: AppColors.white),
                SizedBox(height: 15,),
                CunstomButton(text: "Forgot Password", color: AppColors.primary, textColor: AppColors.white),
                SizedBox(height: 15,),
                CunstomButton(text: "Log Out", color: AppColors.secondary, textColor: AppColors.primary),
              ],
            )),
      ),
    );
  }
}
