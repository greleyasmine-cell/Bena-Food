import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

Widget ActionButton({
  required String label,
  required IconData icon,
  required Color color,
  required VoidCallback onTap,
}){
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,color: AppColors.white,size: 20,),
          SizedBox(width: 5,),
          Text(label,
          style: TextStyle(color: AppColors.white,fontWeight: FontWeight.bold,fontSize: 18),
          )
        ],
      ),
    ),
  );
}