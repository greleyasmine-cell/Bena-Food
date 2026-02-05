import 'package:flutter/material.dart';

Widget infoRow(String label, String value) {
  return Padding(
    padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 8),
    child: Row(
      children: [
        Text("$label ", style: TextStyle(color: Colors.black54)),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  );
}