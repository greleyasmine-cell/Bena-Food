import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Feature/User/cart/manager/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget paymentTile(BuildContext context, String label, IconData icon, String selected) {
  bool isSelected = selected == label;
  return ListTile(
    onTap: () => context.read<CartCubit>().selectPaymentMethod(label),
    leading: Icon(icon, color: AppColors.primary),
    title: Text(label),
    contentPadding: EdgeInsets.zero,
    trailing: Icon(isSelected ? Icons.check_circle : Icons.circle_outlined,
      color: isSelected ? AppColors.primary : Colors.grey,),
  );
}