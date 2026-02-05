import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Widget/adminWidget/order_card.dart';
import 'package:bena_food/Feature/Admin/Orders/manager/admin_order_cubit.dart';
import 'package:bena_food/Feature/Admin/Orders/manager/admin_order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminOrderPage extends StatelessWidget {
  final String restaurantName = "Restaurante";
  final VoidCallback onBack;
  final Function(Map<String, dynamic>) onOrderView;

  const AdminOrderPage({super.key, required this.onOrderView,required this.onBack});

  @override
  Widget build(BuildContext context) {
   context.read<AdminOrderCubit>().fetchOrdersRealTime(restaurantName);
    return SafeArea(
      child: BlocBuilder<AdminOrderCubit, AdminOrderState>(
        builder: (context, state) {
          if (state.status == AdminOrderStatus.loading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          if (state.orders.isEmpty) {
            return Center(
              child: Text(
                "No orders yet.",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(onPressed: onBack, icon: Icon(Icons.arrow_back)),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Order List",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) {
                    final order = state.orders[index];
                    return orderCard(context, order, onOrderView);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
