import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:flutter/material.dart';

Widget infoTag({ IconData? icon, required String label, required Color color}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(25),
    ),
    child: Row(
      children: [
        Icon(icon, size: 16, color: AppColors.white),
        SizedBox(width: 5),
        Text(label, style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 13)),
      ],
    ),
  );
}