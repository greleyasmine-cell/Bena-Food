import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Models/order_model.dart';
import 'package:bena_food/Core/Widget/userWidget/build_order_card.dart';
import 'package:bena_food/Core/Widget/userWidget/build_status_step.dart';
import 'package:flutter/material.dart';

class TrackOrderPage extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onBack;
  const TrackOrderPage({super.key,required this.order,required this.onBack});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            IconButton(icon: Icon(Icons.arrow_back), onPressed: onBack),

            Expanded(
              child: Center(
                child: Text(
                  "Track Order #${order.orderId}",
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
        Container(
          width: double.infinity,
          padding:  EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text("Order ID: #${order.orderId}",
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),

        SizedBox(height: 20,),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))],
          ),
          child: Column(
            children: [
              buildStatusStep("Pending", order.status == "Pending" || order.status == "Preparing" || order.status == "Ready", true),
              buildStatusStep("Preparing", order.status == "Preparing" || order.status == "Ready", true),
              buildStatusStep("Ready", order.status == "Ready", false),
            ],
          ),
        ),
        SizedBox(height: 25),
        Align(alignment: Alignment.centerLeft, child: Text("Order Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
        SizedBox(height: 10),

        buildOrderCard(order),
       SizedBox(height: 30),


        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon:  Icon(Icons.phone),
            label: Text("Contact Restaurant", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
          ),
        ),
      ],
      ),
    ));
  }
}
