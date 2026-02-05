class RestaurantModel {
  final String? id;
  final String? adminId;
  final String name;
  final String image;
  final String status;
  final String category;

  RestaurantModel({
    this.id,
    this.adminId,
    required this.name,
    required this.image,
    required this.status,
    required this.category,
});

  factory RestaurantModel.fromJson(Map<String,dynamic> json,String documentId){
    return RestaurantModel(
      id: documentId,
        adminId: json['adminId'],
        name: json['name'] ?? '',
        image: json['image'] ?? '',
        status: json['status'] ?? 'Open',
        category: json['category'] ?? 'All');
  }

  Map<String,dynamic> toJson(){
    return {
      'name' : name,
      'admin' : adminId,
      'image' : image,
      'status' : status,
      'category' : category,
    };
  }
}