import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:flutter/material.dart';

Widget FoodItemCard({required Map<String, dynamic> food, required VoidCallback onTap}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: AppColors.primary.withAlpha(50),width: 2),
    ),
    child: Row(
      children: [

        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 10)],
              border: Border.all(color: AppColors.primary.withAlpha(50),width: 2)
          ),child: food['image'] != null && food['image'] != ""
        ?Image.network(
          food['image'] ,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context,error, stackTrace) =>
              Container(height: 200,width: double.infinity,decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.primary
              ) ,child: Icon(Icons.restaurant, size: 50,color: AppColors.white,),)
          ,
        )
          :Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.primary
          ),
          child: Icon(Icons.restaurant,size: 40,color: AppColors.white,),
        ),
        ),
        SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(food['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text("${food['price']} DA", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ],
          ),
        ),

        ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
          child: Text("ADD", style: TextStyle(color: Colors.white)),
        )
      ],
    ),
  );
}