import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:flutter/material.dart';

Widget buildSection({required String title, required List<Widget> items}) {
  return Container(
    padding:EdgeInsets.all(15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: AppColors.primary.withAlpha(80)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style:  TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        SizedBox(height: 15),
        ...items,
      ],
    ),
  );
}