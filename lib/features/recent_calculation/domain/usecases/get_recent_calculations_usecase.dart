import 'package:reverse_mortage_loan_app/features/recent_calculation/data/models/recent_calculation_response_model.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/domain/repositories/recent_calculation_repository.dart';

class GetRecentCalculationsUseCase {
  final RecentCalculationRepository _repository;

  GetRecentCalculationsUseCase(this._repository);

  Future<RecentCalculationResponseModel> call({int limit = 10}) {
    return _repository.getCalculations(limit: limit);
  }
}
