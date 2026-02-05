import 'package:flutter/material.dart';

Widget ManageBtn({
  required String label,
  required IconData icon,
  required Color color,
  required VoidCallback onTap,
}) {
  return ElevatedButton.icon(
    onPressed: onTap,
    icon: Icon(icon, color: Colors.white, size: 18),
    label: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}