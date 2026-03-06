import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Componants/main%20scaffold%20user/main_scaffold.dart';
import 'package:bena_food/Core/Componants/main%20scaffold%20admin/main_scaffold_admin.dart';
import 'package:bena_food/Core/Widget/adminWidget/admin_restaurant_card.dart';
import 'package:bena_food/Feature/Admin/Add%20Restaurant/manager/add_restaurant_cubit.dart';
import 'package:bena_food/Feature/Admin/Add%20Restaurant/manager/add_restaurant_state.dart';
import 'package:bena_food/Feature/Auth/manager/auth_cubit.dart';
import 'package:bena_food/Feature/Auth/manager/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminHomePage extends StatelessWidget {
  final Function(Map<String, dynamic>) onEdit;
  final Function(Map<String, dynamic>) onView;
  const AdminHomePage({super.key, required this.onEdit, required this.onView});

  @override
  Widget build(BuildContext context) {
    context.read<AddRestaurantCubit>().getRestaurants();
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset("assets/logo/bena_food.png", width: 120),
              SizedBox(width: 20),
              Text(
                "My Restaurants",
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(width: 40),
              Row(
                children: [
                  Stack(
                    children: [
                      Icon(
                        Icons.notifications,
                        size: 30,
                        color: AppColors.black,
                      ),
                      Positioned(
                        right: 0,
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Icon(Icons.more_vert, size: 30, color: AppColors.black),
            ],
          ),

          Padding(
            padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                String userName = state.userName ?? FirebaseAuth.instance.currentUser?.displayName ?? 'Admin';
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColors.primary,
                      child: Icon(
                        Icons.person,
                        color: AppColors.white,
                        size: 35,
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      "Hi $userName",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "My Restaurants",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: BlocBuilder<AddRestaurantCubit, AddRestaurantState>(
              builder: (context, state) {
                if (state.restaurants.isNotEmpty) {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    itemCount: state.restaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = state.restaurants[index];
                      return AdminRestaurantCard(
                        context,
                        restaurant,
                        onEdit,
                        onView,
                      );
                    },
                  );
                }
                if (state.getStatus == RestaurantStatus.loading) {
                  return Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }
                return Center(
                  child: Text(
                    "No restaurants found",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
