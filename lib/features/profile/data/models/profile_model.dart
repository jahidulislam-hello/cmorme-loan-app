class ProfileModel {
  final String id;
  final String firstName;
  final String? lastName;
  final String email;
  final String role;
  final String? phone;
  final String? address;
  final String? image;

  ProfileModel({
    required this.id,
    required this.firstName,
    this.lastName,
    required this.email,
    required this.role,
    this.phone,
    this.address,
    this.image,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String?,
      email: json['email'] as String,
      role: json['role'] as String,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      image: json['image'] as String?,
    );
  }
}
