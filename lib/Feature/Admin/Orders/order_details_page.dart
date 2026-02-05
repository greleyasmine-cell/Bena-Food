import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Widget/adminWidget/action_button.dart';
import 'package:bena_food/Core/Widget/adminWidget/build_data_cell.dart';
import 'package:bena_food/Core/Widget/adminWidget/build_header_cell.dart';
import 'package:bena_food/Feature/Admin/Orders/manager/admin_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderDetailsPage extends StatelessWidget {
  final Map<String, dynamic> order;
  final VoidCallback onBack;
  const OrderDetailsPage({super.key,required this.order,required this.onBack});

  @override
  Widget build(BuildContext context) {
    final List items = order['items'] as List? ?? [];
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(

            children: [
              IconButton(onPressed: onBack, icon: Icon(Icons.arrow_back)),
              Expanded(child: Center(child: Text("Order Details",style: TextStyle(color: AppColors.primary,fontSize: 20,fontWeight: FontWeight.bold),)))
            ],
          ),
          SizedBox(height: 20,),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text("Customer Information :",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                 SizedBox(height: 15),
                Text("Name : ${order['clientName'] ?? 'Unknown'}",
                    style:  TextStyle(color: Colors.white, fontSize: 16)),
                 SizedBox(height: 10),
                Text("Phone : ${order['phone'] ?? 'N/A'}",
                    style: TextStyle(color: Colors.white, fontSize: 16)),


              ],
            ),

          ),

          SizedBox(height: 25,),
          Container(
            width: double.infinity,
            padding:  EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color:AppColors.primary),
              borderRadius: BorderRadius.circular(25),
            ),
            child:  Center(
              child: Text("Order Items",
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(height: 15),
          Table(
            border: TableBorder.all(color: AppColors.primary),
            columnWidths:  {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(2),
            },
            children: [

              TableRow(
                decoration:  BoxDecoration(color: AppColors.primary),
                children: [
                  buildHeaderCell("Item Name"),
                  buildHeaderCell("Quantity"),
                  buildHeaderCell("Price"),
                  buildHeaderCell("Total"),
                ],
              ),

              ...items.map((item) {
                return TableRow(
                  children: [
                    buildDataCell(item['name'] ?? 'N/A'),
                    buildDataCell("${item['quantity']}"),
                    buildDataCell("${item['price']} DA"),
                    buildDataCell("${(item['price'] * item['quantity'])} DA"),
                  ],
                );
              }),
            ],
          ),

           SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Total Amount: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text("${order['total']} DA",
                  style:  TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 40),
          
          ActionButton(label: "Mark As Ready",
              icon: Icons.check_circle_outline,
              onTap: (){
              context.read<AdminOrderCubit>().updateStatus(
                  order['docId'],
                  "Ready",
                  order['userId'],
                  order['orderId']


              );
              Fluttertoast.showToast(
                  msg: "Order marked as Ready!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);

              onBack();
              },
            color: Colors.green,
          ),
          SizedBox(height: 15),
          ActionButton(label: "cancel",
            icon:Icons.cancel_outlined,
            onTap: (){
              context.read<AdminOrderCubit>().updateStatus(
                  order['docId'],
                  "Cancelled",
                  order['userId'],
                  order['orderId']
              );
              Fluttertoast.showToast(
                  msg: "Order has been Cancelled!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);

              onBack();
            },
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
