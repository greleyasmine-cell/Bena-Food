import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:flutter/cupertino.dart';

Widget CategorItem({
  required String title,
required bool isSelected,
required VoidCallback onTap,
}){
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.white,
        borderRadius:  BorderRadius.circular(25),
        border: Border.all(color: AppColors.primary,width: 1.5),
        boxShadow: [
          if(isSelected)
            BoxShadow(
              color: AppColors.primary.withAlpha(30),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.white : AppColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    ),
  );
}