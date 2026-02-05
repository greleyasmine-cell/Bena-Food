import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Widget/adminWidget/manage_btn.dart';
import 'package:flutter/material.dart';

class RestaurantDetailsPage extends StatelessWidget {
  final Map<String,dynamic> data;
  final VoidCallback onBack;
  final VoidCallback onManageFoods;
  const RestaurantDetailsPage({super.key,
  required this.data,
    required this.onBack,
    required this.onManageFoods,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(onPressed: onBack, icon: Icon(Icons.arrow_back)),
              Expanded(
                child: Center(child: Text("Restaurant Details",
                style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: AppColors.primary),
                ),),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 10)],
                border: Border.all(color: AppColors.primary.withAlpha(50),width: 2)
            ),child: Column(
            children: [
              Image.network(
                data['image'] ?? "",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context,error, stackTrace) =>
                   Container(height: 200,width: double.infinity,decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(20),
                        color: AppColors.primary
                   ) ,child: Icon(Icons.restaurant, size: 50,color: AppColors.white,),)
                ,
              ),
              Padding(padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data['name'] ?? "",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text("Status : "),
                      Text(data['status'] ?? "Close",
                      style: TextStyle(color: data['status'] == "Open" ? Colors.green : Colors.red,fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Divider(height: 30),
                  Text("Description", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                  SizedBox(height: 5),
                  Text(data['description'] ?? "No description available.", style: TextStyle(color: Colors.grey[600])),
                ],
              ),
              )
            ],
          ),
          ),

          SizedBox(height: 30),
          
          Row(
            children: [
              Expanded(child:ManageBtn(
                label: "Manage Foods",
                icon: Icons.fastfood,
                color: AppColors.primary,
                onTap: () {
                  onManageFoods();
                },)),
              SizedBox(width: 15),
              Expanded(child:ManageBtn(
    label: "Manage Orders",
    icon: Icons.receipt_long,
    color: AppColors.primary,
    onTap: () {

    },))
            ],
          )
        ],
      ),
    ));
  }
}
