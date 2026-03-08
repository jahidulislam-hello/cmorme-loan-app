import 'package:reverse_mortage_loan_app/features/recent_calculation/data/models/recent_calculation_response_model.dart';

abstract class RecentCalculationRepository {
  Future<RecentCalculationResponseModel> getCalculations({int limit = 10});
  Future<RecentCalculationItemModel> getCalculationById(String id);
  Future<void> deleteCalculation(String id);
}
