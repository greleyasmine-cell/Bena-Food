
import 'package:bena_food/Core/Models/order_model.dart';
import 'package:bena_food/Feature/User/Order/manager/orders_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersState());

  void fetchMyOrders() {
    emit(state.copyWith(status: OrdersStatus.loading));

    try {
      final String uid = FirebaseAuth.instance.currentUser!.uid;


      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('orders')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .listen((snapshot) {

        List<OrderModel> ordersList = snapshot.docs.map((doc) {
          return OrderModel.fromJson(doc.data());
        }).toList();

        emit(state.copyWith(status: OrdersStatus.success, orders: ordersList));
      }, onError: (e) {
        emit(state.copyWith(status: OrdersStatus.error, errorMessage: e.toString()));
      });
    } catch (e) {
      emit(state.copyWith(status: OrdersStatus.error, errorMessage: e.toString()));
    }
  }
}