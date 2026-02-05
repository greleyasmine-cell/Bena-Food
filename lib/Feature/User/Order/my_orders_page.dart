import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Models/order_model.dart';
import 'package:bena_food/Core/Widget/userWidget/build_order_card.dart';
import 'package:bena_food/Feature/User/Order/manager/orders_cubit.dart';
import 'package:bena_food/Feature/User/Order/manager/orders_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersPage extends StatelessWidget {
  final VoidCallback onBack;
  final Function(OrderModel order) onOrderTap;

  const MyOrdersPage({super.key, required this.onBack,required this.onOrderTap});

  @override
  Widget build(BuildContext context) {
    context.read<OrdersCubit>().fetchMyOrders();
    return SafeArea(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            IconButton(icon: Icon(Icons.arrow_back), onPressed: onBack),

            Expanded(
              child: Center(
                child: Text(
                  "Orders List",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 20,),
        Expanded(
          child: BlocBuilder<OrdersCubit, OrdersState>(
            builder: (context, state) {
              if (state.status == OrdersStatus.loading) {
                return const Center(child: CircularProgressIndicator(color: AppColors.primary,));
              }
          
          
              if (state.status == OrdersStatus.error) {
                return Center(child: Text("Error: ${state.errorMessage}"));
              }
          
          
              if (state.orders.isEmpty) {
                return const Center(child: Text("No orders yet"));
              }
              return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  itemCount: state.orders.length,
                  itemBuilder: (context,index){
                    final order = state.orders[index];
                    return GestureDetector(
                      onTap: ()=>onOrderTap(order),
                        child: buildOrderCard(order));
                  });
            },
          ),
        )
      ],
    ));
  }
}
