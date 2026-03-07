class UpdateProfileRequestModel {
  final String? firstName;
  final String? lastName;
  final String? address;
  final String? image;

  UpdateProfileRequestModel({
    this.firstName,
    this.lastName,
    this.address,
    this.image,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (firstName != null) map['first_name'] = firstName;
    if (lastName != null) map['last_name'] = lastName;
    if (address != null) map['address'] = address;
    if (image != null) map['image'] = image;
    return map;
  }
}
