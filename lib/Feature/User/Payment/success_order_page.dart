import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Widget/userWidget/action_button.dart';
import 'package:bena_food/Core/Widget/userWidget/order_details_card.dart';
import 'package:bena_food/Feature/User/cart/manager/cart_cubit.dart';
import 'package:bena_food/Feature/User/cart/manager/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuccessOrderPage extends StatelessWidget {
  final VoidCallback onGoHome;
  final Function(Map<String, dynamic> order) onTrackOrder;
  const SuccessOrderPage({super.key ,required this.onGoHome,required this.onTrackOrder,});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final order = state.lastOrderData;
        if (order == null) return Center(child: CircularProgressIndicator(color: AppColors.primary,));
        return Padding(padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 100),
              SizedBox(height: 20),
              Text(
                "Your order has been placed successfully!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              orderDetailsCard(order),
              SizedBox(height: 40),
              Row(
                children: [
                  Expanded(child: actionButton(
                      "Track Order",
                      AppColors.primary,
                      Colors.white,
                        () => onTrackOrder(order),)),

                  SizedBox(width: 10),
                  Expanded(
                    child: actionButton(
                        "Go to Home",
                        Colors.white,
                        AppColors.primary,
                            onGoHome,
                        isOutlined: true,

                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    ));
  }
}
