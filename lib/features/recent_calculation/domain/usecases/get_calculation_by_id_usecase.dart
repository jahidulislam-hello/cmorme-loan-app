import 'package:reverse_mortage_loan_app/features/recent_calculation/data/models/recent_calculation_response_model.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/domain/repositories/recent_calculation_repository.dart';

class GetCalculationByIdUseCase {
  final RecentCalculationRepository _repository;

  GetCalculationByIdUseCase(this._repository);

  Future<RecentCalculationItemModel> call(String id) {
    return _repository.getCalculationById(id);
  }
}
