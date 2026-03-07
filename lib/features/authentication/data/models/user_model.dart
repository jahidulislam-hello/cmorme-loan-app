class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String? phone;
  final String? address;
  final String? image;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    this.phone,
    this.address,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] ?? '',
      email: json['email'] as String,
      role: json['role'] as String,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      image: json['image'] as String?,
    );
  }
}
