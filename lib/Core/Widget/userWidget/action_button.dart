import 'package:flutter/material.dart';

Widget actionButton(String text, Color bg, Color textCol, VoidCallback onTap, {bool isOutlined = false}) {
  return SizedBox(
    height: 50,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        side: isOutlined ? BorderSide(color: textCol) : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 0,
      ),
      child: Text(text, style: TextStyle(color: textCol, fontWeight: FontWeight.bold)),
    ),
  );
}