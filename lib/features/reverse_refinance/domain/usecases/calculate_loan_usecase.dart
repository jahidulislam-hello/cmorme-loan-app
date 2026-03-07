import 'package:reverse_mortage_loan_app/features/reverse_refinance/data/models/calculate_loan_request_model.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/data/models/calculate_loan_response_model.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/domain/repositories/reverse_refinance_repository.dart';

class CalculateLoanUseCase {
  final ReverseRefinanceRepository _repository;

  CalculateLoanUseCase(this._repository);

  Future<CalculateLoanResponseModel> call(CalculateLoanRequestModel request) async {
    return await _repository.calculateLoan(request);
  }
}
