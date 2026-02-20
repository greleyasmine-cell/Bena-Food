import 'package:bena_food/Core/Componants/main%20scaffold%20user/main_scaffold.dart';
import 'package:bena_food/Core/Models/order_model.dart';
import 'package:bena_food/Feature/Edit/Edit%20Profile/edit_profile.dart';
import 'package:bena_food/Feature/Edit/Forgot%20Password/forgot_password.dart';
import 'package:bena_food/Feature/Profile/manager/home_cubit.dart';
import 'package:bena_food/Feature/Profile/profile_user/user_profile_page.dart';
import 'package:bena_food/Feature/User/Food%20List/food_details_page.dart';
import 'package:bena_food/Feature/User/Food%20List/user_food_list.dart';
import 'package:bena_food/Feature/User/Order/manager/orders_cubit.dart';
import 'package:bena_food/Feature/User/Order/manager/orders_state.dart';
import 'package:bena_food/Feature/User/Order/my_orders_page.dart';
import 'package:bena_food/Feature/User/Payment/payment_failed_page.dart';
import 'package:bena_food/Feature/User/Payment/payment_page.dart';
import 'package:bena_food/Feature/User/Payment/success_order_page.dart';
import 'package:bena_food/Feature/User/Payment/track_order_page.dart';
import 'package:bena_food/Feature/User/cart/user_cart_page.dart';
import 'package:bena_food/Feature/User/user_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserLayout extends StatefulWidget {
  const UserLayout({super.key});

  @override

  State<UserLayout> createState() => _UserLayoutState();
}

class _UserLayoutState extends State<UserLayout> {
  int displayIndex = 0;
  int navbarIndex = 0;
  Map<String, dynamic>? selectedRestaurant;
  Map<String, dynamic>? selectedFood;
  double totalCartPrice = 0.0;
  OrderModel? selectedOrder;
  String? selectedOwnerId;

  @override
  void initState() {
    super.initState();

    context.read<HomeCubit>().getProfile();
  }
  @override
  Widget build(BuildContext context) {
    final user = context.watch<HomeCubit>().state.userModel;
    final List<Widget> pages = [
      UserHomePage(
        onRestaurantTap: (data) {
          setState(() {
            selectedRestaurant = data;
            displayIndex = 5;
            navbarIndex = 0;
          });
        },
      ),
      MyOrdersPage(
        onBack: () {
          setState(() {
            displayIndex = 0;
            navbarIndex = 0;
          });
        },
        onOrderTap: (order) {
          setState(() {
            selectedOrder = order;
            displayIndex = 10;
          });
        },
      ),
      Center(child: Text("Search")),
      UserCartPage(
        onBack: () {
          setState(() {
            displayIndex = 0;
            navbarIndex = 0;
          });
        },
        onOrderNow: (total,resName,ownerId){
          setState(() {
            totalCartPrice = total;
            selectedRestaurant = {
              'name' : resName,
              'id' : selectedRestaurant?['id'],
            };
            selectedOwnerId = ownerId;
            displayIndex = 7;
          });
        },
      ),
      UserProfilePage(
        onForgotPasswordTap: () {
          setState(() {
            displayIndex = 11;
          });
        },
        onEditProfileTap: ()=> setState(() => displayIndex = 12),
      ),
    ];
    Widget currentWidget;

    if (displayIndex == 5 && selectedRestaurant != null) {
      currentWidget = UserFoodList(
        restaurantId: selectedRestaurant!['id'],
        restaurantName: selectedRestaurant!['name'],
        onBack: () => setState(() => displayIndex = 0),
        onFoodTap: (food) => setState(() { selectedFood = food; displayIndex = 6; }),
      );
    } else if (displayIndex == 6 && selectedFood != null) {
      currentWidget = FoodDetailsPage(food: selectedFood!, onBack: () => setState(() => displayIndex = 5));
    } else if (displayIndex == 7) {
      currentWidget = PaymentPage(
        totalAmount: totalCartPrice,
        restaurantName: selectedRestaurant?['name'] ?? "Restaurant",
        ownerId: selectedOwnerId ?? "",
        onBack: () => setState(() => displayIndex = 3),
        onOrderStatusChanged: (status) => setState(() => displayIndex = (status == "success") ? 8 : 9),
      );
    } else if (displayIndex == 8) {
      currentWidget = SuccessOrderPage(
        onGoHome: () => setState(() { displayIndex = 0; navbarIndex = 0; }),
        onTrackOrder: (orderData) => setState(() { selectedOrder = OrderModel.fromJson(orderData); displayIndex = 10; }),
      );
    } else if (displayIndex == 9) {
      currentWidget = PaymentFailedPage(onRetry: () => setState(() => displayIndex = 7));
    } else if (displayIndex == 10 && selectedOrder != null) {
      currentWidget = BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          final updatedOrder = state.orders.firstWhere((o) => o.orderId == selectedOrder!.orderId, orElse: () => selectedOrder!);
          return TrackOrderPage(order: updatedOrder, onBack: () => setState(() => displayIndex = 1));
        },
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

        currentWidget = pages[displayIndex < pages.length ? displayIndex : 0];
      }
      return MainScaffold(
        currentIndex: navbarIndex,
        onTap: (index) {
          setState(() {
            navbarIndex = index;
            displayIndex = index;
            // if (index != 0) selectedRestaurant = null;
          });
        },
        child: currentWidget,
      );
    }
  }

