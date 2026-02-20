import 'package:bena_food/Feature/Admin/Orders/manager/admin_order_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminOrderCubit extends Cubit<AdminOrderState> {
  AdminOrderCubit() : super(AdminOrderState());


  void fetchOrdersRealTime(String restaurantName) {
    final String? adminId = FirebaseAuth.instance.currentUser?.uid;
    if (adminId == null) return;
    emit(state.copyWith(status: AdminOrderStatus.loading));


    FirebaseFirestore.instance
        .collection('orders')
       // .where('restaurantName', isEqualTo: restaurantName)
        .where('ownerId', isEqualTo: adminId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      final orders = snapshot.docs.map((doc) {
        var data = doc.data();
        data['docId'] = doc.id;
        return data;
      }).toList();

      emit(state.copyWith(status: AdminOrderStatus.success, orders: orders));
    }, onError: (e) {
      emit(state.copyWith(status: AdminOrderStatus.error, errorMessage: e.toString()));
    });
  }


  Future<void> updateStatus(String docId, String newStatus, String userId, String orderId) async {
    try {

      await FirebaseFirestore.instance.collection('orders').doc(docId).update({
        'status': newStatus,
      });


      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('orders')
          .where('orderId', isEqualTo: orderId)
          .get()
          .then((snapshot) {
        for (var doc in snapshot.docs) {
          doc.reference.update({'status': newStatus});
        }
      });

    } catch (e) {
      print("Error updating status: $e");
    }
  }
}