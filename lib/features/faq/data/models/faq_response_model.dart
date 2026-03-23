class FaqItemModel {
  final String id;
  final String question;
  final String answer;

  FaqItemModel({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory FaqItemModel.fromJson(Map<String, dynamic> json) {
    return FaqItemModel(
      id: json['_id'] as String,
      question: json['question'] as String,
      answer: json['ans'] as String,
    );
  }
}
