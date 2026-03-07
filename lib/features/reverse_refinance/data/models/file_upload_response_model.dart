class FileUploadResponseModel {
  final String path;
  final String url;

  FileUploadResponseModel({required this.path, required this.url});

  factory FileUploadResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return FileUploadResponseModel(
      path: data['path'] as String,
      url: data['url'] as String,
    );
  }
}
