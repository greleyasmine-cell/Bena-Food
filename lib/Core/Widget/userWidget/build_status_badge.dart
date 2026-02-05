import 'package:flutter/material.dart';

Widget buildStatusBadge(String status) {
  Color color;
  IconData icon;
  if (status == "Ready") {
    color = Colors.green;
    icon = Icons.check_circle;
  } else if (status == "Cancelled") {
    color = Colors.red;
    icon = Icons.cancel;
  } else {
    color = Colors.orange;
    icon = Icons.access_time_filled;
  }
  return Container(
    padding:  EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 12),
        SizedBox(width: 4),
        Text(status, style: TextStyle(color: Colors.white, fontSize: 10)),
      ],
    ),
  );
}