import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Widget/adminWidget/action_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget FoodCard({
  required String name,
  required String price,
  required String image,
  VoidCallback? onEdit,
  VoidCallback? onDelete,
}){
  return Container(

    margin: EdgeInsets.only(bottom: 15),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: AppColors.primary.withAlpha(80))
    ),child: Row(
    children: [
      Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 10)],
            border: Border.all(color: AppColors.primary.withAlpha(50),width: 2)
        ),child: Image.network(
          image,
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
      ),
      SizedBox(width: 15,),
      Expanded(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text("$price DA", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
        ],
      ),
      ),
      Column(
        children: [
          ActionButton(
              label: "Edit",
              icon: Icons.edit,
            onTap:onEdit ?? (){},
           color: AppColors.primary
          ),
          SizedBox(height: 8,),
          ActionButton(label: "Delete",
              icon: Icons.delete,
              onTap: onDelete ?? (){},
              color: AppColors.primary
          )
        ],
      )
    ],
  )
    ,
  );
}