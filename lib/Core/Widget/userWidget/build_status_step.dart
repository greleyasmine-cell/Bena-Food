import 'package:flutter/material.dart';

Widget buildStatusStep(String title, bool isDone, bool showLine) {
  return Row(
    children: [
      Column(
        children: [
          Icon(isDone ? Icons.check_circle : Icons.radio_button_unchecked, color: isDone ? Colors.green : Colors.grey),
          if (showLine) Container(width: 2, height: 40, color: isDone ? Colors.green : Colors.grey),
        ],
      ),
       SizedBox(width: 10),
      Text(title, style: TextStyle(fontWeight: isDone ? FontWeight.bold : FontWeight.normal)),
    ],
  );
}