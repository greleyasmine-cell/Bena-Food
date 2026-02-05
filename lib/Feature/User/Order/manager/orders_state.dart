import 'package:bena_food/Core/Models/order_model.dart';

enum OrdersStatus { initial, loading, success, error }

class OrdersState {
  final OrdersStatus status;
  final List<OrderModel> orders;
  final String? errorMessage;

  OrdersState({
    this.status = OrdersStatus.initial,
    this.orders = const [],
    this.errorMessage,
  });

  OrdersState copyWith({
    OrdersStatus? status,
    List<OrderModel>? orders,
    String? errorMessage,
  }) {
    return OrdersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}