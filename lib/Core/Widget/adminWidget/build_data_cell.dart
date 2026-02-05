import 'package:flutter/material.dart';

Widget buildDataCell(String text) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: Text(text, textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
  );
}