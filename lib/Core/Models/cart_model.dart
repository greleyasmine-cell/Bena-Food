class CartModel {
  final String id;
  final String name;
  final double price;
  final String image;
  final String ownerId;
  final String restaurantName;
  int quantity;

  CartModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.ownerId,
    required this.restaurantName,
    this.quantity = 1,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      ownerId: json['ownerId'] ?? '',
      restaurantName: json['restaurantName'] ?? '',
      quantity: json['quantity'] ?? 1,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'ownerId': ownerId,
      'restaurantName': restaurantName,
      'quantity': quantity,
    };
  }
}