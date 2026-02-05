import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Models/order_model.dart';
import 'package:bena_food/Core/Widget/userWidget/build_status_badge.dart';
import 'package:flutter/material.dart';

Widget buildOrderCard(OrderModel order) {
  return Container(
    margin:  EdgeInsets.only(bottom: 15),
    padding:  EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.orange.shade200),
      boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5)],
    ),
    child: Column(
      children: [
        Row(
          children: [

            CircleAvatar(
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Icon(Icons.restaurant, color: AppColors.primary),
            ),
             SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(order.restaurantName, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Order ID: ${order.orderId} | ${order.date}", style:  TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
            ),

            buildStatusBadge(order.status),
          ],
        ),
         Divider(),

        ...order.items.map((item) => Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item['name'] ?? ''),
              Text("x${item['quantity']}"),
            ],
          ),
        )).toList(),
         Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total Amount:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("${order.total} DA", style:  TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    ),
  );
}