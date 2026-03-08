import 'package:reverse_mortage_loan_app/features/recent_calculation/data/datasources/recent_calculation_remote_datasource.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/data/models/recent_calculation_response_model.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/domain/repositories/recent_calculation_repository.dart';

class RecentCalculationRepositoryImpl implements RecentCalculationRepository {
  final RecentCalculationRemoteDatasource _datasource;

  RecentCalculationRepositoryImpl(this._datasource);

  @override
  Future<RecentCalculationResponseModel> getCalculations({int limit = 10}) {
    return _datasource.getCalculations(limit: limit);
  }

  @override
  Future<RecentCalculationItemModel> getCalculationById(String id) {
    return _datasource.getCalculationById(id);
  }

  @override
  Future<void> deleteCalculation(String id) {
    return _datasource.deleteCalculation(id);
  }
}
