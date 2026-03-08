class LegalResponseModel {
  final String id;
  final String description;
  final String createdAt;
  final String updatedAt;

  LegalResponseModel({
    required this.id,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LegalResponseModel.fromJson(Map<String, dynamic> json) {
    return LegalResponseModel(
      id: json['_id'] as String,
      description: json['description'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }
}
