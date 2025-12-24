import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:flutter/material.dart';

Widget InfoUser({required IconData icon, required String label, }){
  return Container(
    margin:  EdgeInsets.only(bottom: 15),
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: AppColors.primary),
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withAlpha(1),
          blurRadius: 10,
          spreadRadius: 2,
          offset: Offset(0,4),
        )
      ]
    ),
    child: Row(
      children: [
        Icon(icon,color: AppColors.primary,size: 24,),
        SizedBox(width: 15,),
        Text(label,style: TextStyle(color: AppColors.primary,fontSize: 12 ,fontWeight: FontWeight.bold),)
      ],
    ),
  );
}