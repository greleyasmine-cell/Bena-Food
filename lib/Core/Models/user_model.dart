class UserModel {
  final String fullName;
  final String email;
  final String phone;
  final String country;
  final String wilaya;
  final String userType;
  final String? profileImage;

  UserModel({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.country,
    required this.wilaya,
    required this.userType,
    this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      country: json['country'] ?? '',
      wilaya: json['wilaya'] ?? '',
      userType: json['userType'] ?? '',
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'country': country,
      'wilaya': wilaya,
      'userType': userType,
      'profileImage': profileImage,
    };
  }
}