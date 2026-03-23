import 'package:reverse_mortage_loan_app/features/faq/data/models/faq_response_model.dart';
import 'package:reverse_mortage_loan_app/features/faq/domain/repositories/faq_repository.dart';

class GetFaqsUseCase {
  final FaqRepository _repository;

  GetFaqsUseCase(this._repository);

  Future<List<FaqItemModel>> call() => _repository.getFaqs();
}
