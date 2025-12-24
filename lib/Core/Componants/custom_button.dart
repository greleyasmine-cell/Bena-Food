import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:flutter/material.dart';

class CunstomButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback? onPressed;
  const CunstomButton({super.key,required this.text,
    required this.color,
    required this.textColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
        ),
        child: Text(text,style: TextStyle(color: textColor ,fontSize: 16),));
  }
}
