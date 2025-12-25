import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Componants/custom_button.dart';
import 'package:bena_food/Core/Widget/info_user.dart';
import 'package:bena_food/Feature/Auth/login_page.dart';
import 'package:bena_food/Feature/Edit/Forgot%20Password/forgot_password.dart';
import 'package:bena_food/Feature/Profile/manager/home_cubit.dart';
import 'package:bena_food/Feature/Profile/manager/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().getProfile();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    if(state.getProfileStatus == GetProfileStatus.loading){
      return Center(child: CircularProgressIndicator(color: AppColors.primary,),);
    }if(state.getProfileStatus == GetProfileStatus.failure){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Error: ${state.errorMessage}"),
            ElevatedButton(onPressed: () => context.read<HomeCubit>().getProfile(),
                child: Text("Retry")),
          ],
        ),
      );
    }
    final user = state.userModel;
    return SingleChildScrollView(
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
                    label: user?.fullName ?? "Loading...",
                ),
                SizedBox(height: 15,),
                InfoUser(
                  icon: Icons.email_rounded,
                  label:  user?.email ?? "Loading...",
                ),
                SizedBox(height: 15,),
                InfoUser(
                  icon: Icons.phone,
                  label:  user?.phone ?? "Loading...",
                ),
                SizedBox(height: 15,),
                InfoUser(
                  icon: Icons.public,
                  label:  user?.country ?? "Loading...",
                ),
                SizedBox(height: 15,),
                InfoUser(
                  icon: Icons.location_city_rounded,
                  label:  user?.wilaya ?? "Loading...",
                ),
                SizedBox(height: 20,),
                CunstomButton(text: "Edit Profile", color: AppColors.primary, textColor: AppColors.white,
                onPressed: (){},
                ),
                SizedBox(height: 15,),
                CunstomButton(text: "Forgot Password", color: AppColors.primary, textColor: AppColors.white,
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                          (route) => false);
                },
                ),
                SizedBox(height: 15,),
                CunstomButton(text: "Log Out", color: AppColors.secondary, textColor: AppColors.primary,
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false);
                },
                ),
              ],
            )),
      );
  },
),
    );
  }
}
