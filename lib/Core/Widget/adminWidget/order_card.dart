import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Widget/adminWidget/info_row.dart';
import 'package:bena_food/Core/Widget/adminWidget/status_badge.dart';
import 'package:flutter/material.dart';

Widget orderCard(BuildContext context, Map<String, dynamic> order,Function(Map<String, dynamic>) onOrderTap) {

  final List items = order['items'] as List? ?? [];


  final Map<String, dynamic> firstItem = items.isNotEmpty ? items.first : {};

  bool isPending = order['status'] == "Pending";
  int totalQuantity = items.fold(0, (sum, item) => sum + (item['quantity'] as int? ?? 0));

  return Container(
    margin:  EdgeInsets.only(bottom: 20, left: 15, right: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: AppColors.primary),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
      ],
    ),
    child: Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: Icon(Icons.restaurant, color: AppColors.primary),
          ),

          title: Text(
              firstItem['name'] ?? 'No Name',
              style:  TextStyle(fontWeight: FontWeight.bold)
          ),
          subtitle: Text("Order ID: ${order['orderId'] ?? 'N/A'}"),
          trailing: statusBadge(order['status'] ?? 'Pending'),
        ),
         Divider(height: 1, indent: 15, endIndent: 15),
        infoRow("client:", order['clientName'] ?? "Unknown"),
         Divider(height: 1, indent: 15, endIndent: 15),
        infoRow("Quantity:", "$totalQuantity"),
         Divider(height: 1, indent: 15, endIndent: 15),
        Padding(
          padding:  EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "Total Amount: ${order['total'] ?? 0} DA",
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16)
              ),
              ElevatedButton.icon(
                onPressed: () => onOrderTap(order),
                icon:  Icon(Icons.visibility, size: 16, color: Colors.white),
                label: Text("View", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}