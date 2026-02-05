import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Widget/userWidget/info_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget orderDetailsCard(Map<String, dynamic> order) {
  return Container(
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: AppColors.primary),
    ),
    child: Column(
      children: [
        infoRow("Order ID:", "#${order['orderId'] ?? '0000'}"),
         Divider(),
        infoRow("Status:", order['status'] ?? 'Pending', valueColor: Colors.orange),
         Divider(),
        infoRow("Restaurant:", order['restaurantName'] ?? 'Bena Food'),
         Divider(),
        infoRow("Total Amount:", "${order['total'] ?? 0} DA"),
         Divider(),
        infoRow("Payment Method:", order['method'] ?? 'Cash'),
      ],
    ),
  );
}