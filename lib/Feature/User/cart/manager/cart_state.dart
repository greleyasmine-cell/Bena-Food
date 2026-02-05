import 'package:bena_food/Core/Models/cart_model.dart';

enum CartStatus { initial, loading, success, error }

class CartState {
  final CartStatus status;
  final List<CartModel> cartItems;
  final double totalPrice;
  final int detailQty;
  final String selectedPaymentMethod;
  final Map<String, dynamic>? lastOrderData;

  CartState({
    required this.status,
    required this.cartItems,
    this.totalPrice = 0,
    this.detailQty = 1,
    this.selectedPaymentMethod = "Cash On Delivery",
    this.lastOrderData,
  });

  CartState copyWith({
    CartStatus? status,
    List<CartModel>? cartItems,
    double? totalPrice,
    int? detailQty,
    String? selectedPaymentMethod,
    Map<String, dynamic>? lastOrderData,
  }) {
    return CartState(
      status: status ?? this.status,
      cartItems: cartItems ?? this.cartItems,
      totalPrice: totalPrice ?? this.totalPrice,
      detailQty: detailQty ?? this.detailQty,
      selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
      lastOrderData: lastOrderData ?? this.lastOrderData,
    );
  }
}