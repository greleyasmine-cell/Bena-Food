import 'dart:ui';

import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:flutter/material.dart';

Widget infoRow(String label, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style:  TextStyle(color: AppColors.primary, fontSize: 16,fontWeight: FontWeight.bold)),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: valueColor ?? Colors.black),
        ),
      ],
    ),
  );
}