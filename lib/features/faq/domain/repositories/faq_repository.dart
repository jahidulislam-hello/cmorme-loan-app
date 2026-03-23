import 'package:reverse_mortage_loan_app/features/faq/data/models/faq_response_model.dart';

abstract class FaqRepository {
  Future<List<FaqItemModel>> getFaqs();
}
