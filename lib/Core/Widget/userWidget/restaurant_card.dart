import 'package:bena_food/Core/Colors/app_colors.dart';
import 'package:flutter/material.dart';

Widget RestaurantCard({
  required String name,
  required String status,
  required String imagePath,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(

      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withAlpha(80),width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withAlpha(5),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(15),
                image: imagePath.isNotEmpty
                ? DecorationImage(
                    image: imagePath.startsWith('http')
                   ?NetworkImage(imagePath)
                        :AssetImage(imagePath) as ImageProvider,
                  fit: BoxFit.cover,
                )
                :null,
              ),
              child: imagePath.isEmpty
              ?Icon(
                Icons.restaurant,
                color: AppColors.white,
                size: 40,
              )
              : null,
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Status:",
                        style: TextStyle(fontSize: 12, color: Colors.grey,fontWeight: FontWeight.bold),
                      ),
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: 12,
                          color: status.trim().toLowerCase() == "open"
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.favorite_border,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
