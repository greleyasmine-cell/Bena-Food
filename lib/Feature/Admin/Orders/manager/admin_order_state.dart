enum AdminOrderStatus { initial, loading, success, error }

class AdminOrderState {
  final AdminOrderStatus status;
  final List<Map<String, dynamic>> orders;
  final String? errorMessage;

  AdminOrderState({
    this.status = AdminOrderStatus.initial,
    this.orders = const [],
    this.errorMessage,
  });

  AdminOrderState copyWith({
    AdminOrderStatus? status,
    List<Map<String, dynamic>>? orders,
    String? errorMessage,
  }) {
    return AdminOrderState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}