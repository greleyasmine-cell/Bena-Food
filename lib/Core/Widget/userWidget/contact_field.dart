import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:flutter/material.dart';

Widget contactField(TextEditingController controller,IconData icon, String hint) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: AppColors.primary),
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),

      ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.primary.withOpacity(0.5), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:  BorderSide(color: AppColors.primary, width: 2),
        )

    ),
  );
}
