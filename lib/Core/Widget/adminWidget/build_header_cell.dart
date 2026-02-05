import 'package:flutter/material.dart';

Widget buildHeaderCell(String text) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: Text(text, textAlign: TextAlign.center,
        style:  TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
  );
}