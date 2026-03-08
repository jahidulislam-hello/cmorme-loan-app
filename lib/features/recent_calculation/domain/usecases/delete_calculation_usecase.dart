import 'package:reverse_mortage_loan_app/features/recent_calculation/domain/repositories/recent_calculation_repository.dart';

class DeleteCalculationUseCase {
  final RecentCalculationRepository _repository;

  DeleteCalculationUseCase(this._repository);

  Future<void> call(String id) {
    return _repository.deleteCalculation(id);
  }
}
