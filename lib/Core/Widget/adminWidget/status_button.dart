import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Feature/Admin/Add%20Restaurant/manager/add_restaurant_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget StatusButton(AddRestaurantCubit cubit, String label , Color color, bool isSelected){
  return Expanded(child: ElevatedButton(
      onPressed: () => cubit.changeStatus(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? color : AppColors.primary.withAlpha(150),

      ),
      child: Text(label,style: TextStyle(color: AppColors.white,fontWeight: FontWeight.bold),)));
}