class CartModel {
  final String id;
  final String name;
  final double price;
  final String image;
  int quantity;

  CartModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
  });
}