import 'package:reverse_mortage_loan_app/features/legal/data/models/legal_response_model.dart';

abstract class LegalRepository {
  Future<LegalResponseModel> getLegalContent(String endpoint);
}
