import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:flutter/material.dart';

Widget DetailItem(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        const SizedBox(width: 10),
        Text(value, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 17)),
      ],
    ),
  );
}