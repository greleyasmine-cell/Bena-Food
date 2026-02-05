import 'package:flutter/material.dart';

Widget statusBadge(String status) {

  Color color;
  IconData icon;

  if (status == "Cancelled") {
    color = Colors.red;
    icon = Icons.cancel;
  } else if (status == "Ready" || status == "Delivered") {
    color = Colors.green;
    icon = Icons.check_circle;
  } else {

    color = Colors.orange;
    icon = Icons.access_time;
  }

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.white),
        SizedBox(width: 4),
        Text(
          status,
          style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold
          ),
        ),
      ],
    ),
  );
}