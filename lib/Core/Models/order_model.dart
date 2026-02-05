import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String orderId;
  final String restaurantName;
  final String status;
  final double total;
  final String date;
  final List items;

  OrderModel({
    required this.orderId,
    required this.restaurantName,
    required this.status,
    required this.total,
    required this.date,
    required this.items,
  });


  factory OrderModel.fromJson(Map<String, dynamic> json) {
    String formatTimestamp(dynamic timestamp) {
      if (timestamp is Timestamp) {
        return timestamp.toDate().toString().substring(0, 16);
      } else if (timestamp is String) {
        return timestamp;
      } else {

        return DateTime.now().toString().substring(0, 16);
      }
    }
    return OrderModel(
      orderId: json['orderId'] ?? '',
      restaurantName: json['restaurantName'] ?? 'Restaurant',
      status: json['status'] ?? 'Pending',
      total: (json['total'] ?? 0).toDouble(),

      date: formatTimestamp(json['timestamp']),
      items: json['items'] ?? [],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'restaurantName': restaurantName,
      'status': status,
      'total': total,
      'items': items,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }
}