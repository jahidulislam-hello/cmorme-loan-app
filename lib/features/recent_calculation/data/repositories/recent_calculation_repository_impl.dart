import 'package:reverse_mortage_loan_app/core/exceptions/app_exceptions.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/data/datasources/recent_calculation_local_datasource.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/data/datasources/recent_calculation_remote_datasource.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/data/models/recent_calculation_response_model.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/domain/repositories/recent_calculation_repository.dart';

class RecentCalculationRepositoryImpl implements RecentCalculationRepository {
  final RecentCalculationRemoteDatasource _remoteDatasource;
  final RecentCalculationLocalDatasource _localDatasource;

  RecentCalculationRepositoryImpl(
    this._remoteDatasource,
    this._localDatasource,
  );

  @override
  Future<RecentCalculationResponseModel> getCalculations({int limit = 10, int page = 1}) async {
    try {
      final response = await _remoteDatasource.getCalculations(limit: limit, page: page);
      // Only cache page 1 — it's the freshest data and what offline users will see
      if (page == 1) await _localDatasource.cacheCalculations(response.data);
      return response;
    } on NoInternetException {
      // Offline — try serving from cache (page 1 only)
      if (page == 1) {
        final cached = await _localDatasource.getCachedCalculations();
        if (cached.isNotEmpty) return RecentCalculationResponseModel.fromCache(cached);
      }
      rethrow; // no cache either — let the controller show "No Internet"
    }
  }

  @override
  Future<RecentCalculationItemModel> getCalculationById(String id) {
    return _remoteDatasource.getCalculationById(id);
  }

  @override
  Future<void> deleteCalculation(String id) {
    return _remoteDatasource.deleteCalculation(id);
  }
}
