import 'package:bena_food/Feature/Admin/Orders/manager/admin_order_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminOrderCubit extends Cubit<AdminOrderState> {
  AdminOrderCubit() : super(AdminOrderState());

  Future<void> fetchOrdersRealTime() async {
    final String? adminId = FirebaseAuth.instance.currentUser?.uid;
    if (adminId == null) return;

    emit(state.copyWith(status: AdminOrderStatus.loading));

    try {

      QuerySnapshot restaurantSnapshot = await FirebaseFirestore.instance
          .collection('restaurants')
          .where('adminId', isEqualTo: adminId)
          .limit(1)
          .get();

      if (restaurantSnapshot.docs.isEmpty) {
        emit(state.copyWith(status: AdminOrderStatus.success, orders: []));
        return;
      }

      String restaurantName = restaurantSnapshot.docs.first['name'];



      FirebaseFirestore.instance
          .collection('orders')
          .where('restaurantName', isEqualTo: restaurantName)
          .snapshots()
          .listen((snapshot) {
        final orders = snapshot.docs.map((doc) {
          var data = doc.data();
          data['docId'] = doc.id;
          return data;
        }).toList();

        emit(state.copyWith(status: AdminOrderStatus.success, orders: orders));
      });
    } catch (e) {
      emit(state.copyWith(status: AdminOrderStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> updateStatus(String docId, String newStatus, String userId, String orderId) async {
    try {
      await FirebaseFirestore.instance.collection('orders').doc(docId).update({
        'status': newStatus,
      });


      var userOrders = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('orders')
          .where('orderId', isEqualTo: orderId)
          .get();

      for (var doc in userOrders.docs) {
        await doc.reference.update({'status': newStatus});
      }
    } catch (e) {
      print("Error updating status: $e");
    }
  }
}