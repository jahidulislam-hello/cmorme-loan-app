class DidYouKnowResponseModel {
  final List<String> tips;

  DidYouKnowResponseModel({required this.tips});

  factory DidYouKnowResponseModel.fromJson(Map<String, dynamic> json) {
    return DidYouKnowResponseModel(
      tips: (json['data'] as List)
          .map((e) => (e as Map<String, dynamic>)['did_you_know'] as String)
          .toList(),
    );
  }
}
