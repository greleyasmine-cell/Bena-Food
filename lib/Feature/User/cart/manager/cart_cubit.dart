import 'package:bena_food/Core/Models/cart_model.dart';
import 'package:bena_food/Feature/User/cart/manager/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(status: CartStatus.initial, cartItems: []));
  void incDetail() => emit(state.copyWith(detailQty: state.detailQty + 1));

  void decDetail() {
    if (state.detailQty > 1) {
      emit(state.copyWith(detailQty: state.detailQty - 1));
    }
  }

  void resetDetail() => emit(state.copyWith(detailQty: 1));

  void addToCart(CartModel newItem) {
    List<CartModel> items = List.from(state.cartItems);

    int index = items.indexWhere((i) => i.id == newItem.id);
    if (index != -1) {
      items[index].quantity += newItem.quantity;
    } else {
      items.add(newItem);
    }
    calculateTotal(items);
  }


  void increment(int index) {
    state.cartItems[index].quantity++;
    calculateTotal(state.cartItems);
  }

  void decrement(int index) {
    if (state.cartItems[index].quantity > 1) {
      state.cartItems[index].quantity--;
      calculateTotal(state.cartItems);
    }
  }





  Future<void> placeOrder({
    required String phone,
    required String address,

  }) async {

    if (state.cartItems.isEmpty) return;
    final String restaurantName = state.cartItems.first.restaurantName;
    final String ownerId = state.cartItems.first.ownerId;

    emit(state.copyWith(status: CartStatus.loading));
    try {
      final String uid = FirebaseAuth.instance.currentUser!.uid;
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

      final String clientName = userDoc.data()?['fullName'] ?? "Unknown User";

      List itemsMap = state.cartItems.map((item) => {
        'id': item.id,
        'name': item.name,
        'price': item.price,
        'quantity': item.quantity,
        'image': item.image,
      }).toList();

      final orderData = {
        'orderId': DateTime.now().millisecondsSinceEpoch.toString().substring(5),
        'restaurantName': restaurantName,
        'userId': uid,
        'ownerId': ownerId,
        'clientName': clientName,
        'phone': phone,
        'address': address,
        'total': state.totalPrice,
        'method': state.selectedPaymentMethod ,
        'status': 'Pending',

        'items': itemsMap,
        'timestamp': FieldValue.serverTimestamp(),
      };




      await FirebaseFirestore.instance.collection('orders').add(orderData);


      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('orders')
          .add(orderData);


      emit(state.copyWith(
          status: CartStatus.success,
          cartItems: [],
          totalPrice: 0,
          lastOrderData: orderData
      ));
    } catch (e) {
      emit(state.copyWith(status: CartStatus.error));
    }
  }

  void calculateTotal(List<CartModel> items) {
    double total = items.fold(0, (sum, item) => sum + (item.price * item.quantity));
    emit(state.copyWith(cartItems: items, totalPrice: total, status: CartStatus.initial));
  }
  void selectPaymentMethod(String method) {
    emit(state.copyWith(selectedPaymentMethod: method));
  }

}
