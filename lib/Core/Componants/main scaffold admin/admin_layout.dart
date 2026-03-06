import 'package:bena_food/Core/Componants/main%20scaffold%20admin/main_scaffold_admin.dart';
import 'package:bena_food/Feature/Admin/Add%20Restaurant/add_restaurant_page.dart';
import 'package:bena_food/Feature/Admin/Manage%20Foods/add_food.dart';
import 'package:bena_food/Feature/Admin/Manage%20Foods/edit_food.dart';
import 'package:bena_food/Feature/Admin/Manage%20Foods/food_list.dart';
import 'package:bena_food/Feature/Admin/Orders/admin_order_page.dart';
import 'package:bena_food/Feature/Admin/Orders/order_details_page.dart';
import 'package:bena_food/Feature/Admin/admin_home_page.dart';
import 'package:bena_food/Feature/Admin/edit_restaurant_page.dart';
import 'package:bena_food/Feature/Admin/restaurant_details_page.dart';
import 'package:bena_food/Feature/Edit/Edit%20Profile/edit_profile.dart';
import 'package:bena_food/Feature/Edit/Forgot%20Password/forgot_password.dart';
import 'package:bena_food/Feature/Profile/manager/home_cubit.dart';
import 'package:bena_food/Feature/Profile/profile_user/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminLayout extends StatefulWidget {
  const AdminLayout({super.key});

  @override
  State<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout> {
  int displayIndex = 0;
  int navbarIndex = 0;
  Map<String, dynamic>? selectedRestaurant;
  Map<String, dynamic>? selectedFoodData;
  Map<String, dynamic>? selectedOrderData;

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getProfile();
  }
  @override
  Widget build(BuildContext context) {
    final user = context.watch<HomeCubit>().state.userModel;
    final List<Widget> mainPages = [
      AdminHomePage(
        onEdit: (data) => setState(() {
          selectedRestaurant = data;
          displayIndex = 5;
        }),
        onView: (data) => setState(() {
          selectedRestaurant = data;
          displayIndex = 6;
        }),
      ),
      AdminOrderPage(
        restaurantName: selectedRestaurant?['name'] ?? "Restaurante",
        onBack: () {
          setState(() {
            displayIndex = 0;
            navbarIndex = 0;
          });
        },
        onOrderView: (order) => setState(() {
          selectedOrderData = order;
          displayIndex = 10;
        }),
      ),
      AddRestaurantPage(
        onBack: () {
          setState(() {
            displayIndex = 0;
            navbarIndex = 0;
          });
        },
      ),
      selectedRestaurant != null
          ? FoodList(
              restaurantId: selectedRestaurant!['id'],
              restaurantName: selectedRestaurant!['name'],
              onBack: () => setState(() {
                displayIndex = 0;
                navbarIndex = 0;
              }),
              onAddFood: () => setState(() => displayIndex = 8),
              onEditFood: (food) => setState(() {
                selectedFoodData = food;
                displayIndex = 9;
              }),
            )
          : Center(child: Text("Please select a restaurant from Home first")),
      UserProfilePage(
        onForgotPasswordTap: () {
          setState(() {
            displayIndex = 11;
          });
        },
        onEditProfileTap: ()=> setState(() => displayIndex =12),
      ),
    ];

    Widget currentWidget;

    if (displayIndex == 5 && selectedRestaurant != null) {
      currentWidget = EditRestaurantPage(
        restaurantData: selectedRestaurant!,
        onBack: () => setState(() => displayIndex = 0),
      );
    } else if (displayIndex == 6 && selectedRestaurant != null) {
      currentWidget = RestaurantDetailsPage(
        data: selectedRestaurant!,
        onBack: () => setState(() => displayIndex = 0),
        onManageFoods: () => setState(() => displayIndex = 7),
      );
    } else if (displayIndex == 7 && selectedRestaurant != null) {
      currentWidget = FoodList(
        restaurantId: selectedRestaurant!['id'],
        restaurantName: selectedRestaurant!['name'],
        onBack: () => setState(() => displayIndex = 6),
        onAddFood: () => setState(() => displayIndex = 8),
        onEditFood: (food) => setState(() {
          selectedFoodData = food;
          displayIndex = 9;
        }),
      );
    } else if (displayIndex == 8 && selectedRestaurant != null) {
      currentWidget = AddFood(
        restaurantId: selectedRestaurant!['id'],
        onBack: () => setState(() => displayIndex = 7),
      );
    } else if (displayIndex == 9 && selectedFoodData != null) {
      currentWidget = EditFood(
        restaurantId: selectedRestaurant!['id'],
        foodData: selectedFoodData!,
        onBack: () => setState(() => displayIndex = 7),
      );
    } else if (displayIndex == 10 && selectedOrderData != null) {
      currentWidget = OrderDetailsPage(
        order: selectedOrderData!,
        onBack: () => setState(() => displayIndex = 1),
      );
    } else if(displayIndex == 11){
        currentWidget = ForgotPassword(
          fromProfile: true,
        );
      }
    else if(displayIndex == 12){
      currentWidget = EditProfile(
        name: user?.fullName ?? "",
        email: user?.email ?? "",
        phone: user?.phone ?? "",
        country: user?.country ?? "",
        wilaya: user?.wilaya ?? "",
        onBack: () => setState(() => displayIndex = 4),
      );
    }
    else{
      currentWidget =
          mainPages[displayIndex < mainPages.length ? displayIndex : 0];
    }

    return MainScaffoldAdmin(
      currentIndex: navbarIndex,
      onTap: (index) {
        setState(() {
          navbarIndex = index;
          displayIndex = index;
        });
      },
      child: Material(color: Colors.white, child: currentWidget),
    );
  }
}
