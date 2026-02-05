import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:bena_food/Core/Widget/userWidget/action_button.dart';
import 'package:flutter/material.dart';

class PaymentFailedPage extends StatelessWidget {
  final VoidCallback onRetry;
  const PaymentFailedPage({super.key , required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Padding(padding: EdgeInsets.all(20),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.close, color: Colors.red, size: 100),
        SizedBox(height: 20),
        Text(
          "Oh no! Payment Failed",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          "We couldn't process your order. Please try again.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        SizedBox(height: 50),

        Row(
          children: [
            Expanded(child: actionButton(
                "Try Again",
                AppColors.primary,
                Colors.white,
                onRetry)),

            SizedBox(width: 10),
            Expanded(
              child: actionButton(
                  "Go Back",
                  Colors.white,
                  AppColors.primary,
                  onRetry,
                  isOutlined: true
              ),
            ),
          ],
        )
      ],
    ),
    ));
  }
}
