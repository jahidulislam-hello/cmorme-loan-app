import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/core/services/cache_service.dart';
import 'package:reverse_mortage_loan_app/core/utils/isolate_parsers.dart';
import '../models/recent_calculation_response_model.dart';

class RecentCalculationLocalDatasource {
  static const _cacheKey = 'recent_calculations';
  final _logger = Logger();

  /// Serializes [items] in a background isolate and writes to Hive.
  Future<void> cacheCalculations(List<RecentCalculationItemModel> items) async {
    final serialized = await compute(serializeCalculations, items);
    await CacheService().put(_cacheKey, serialized);
    _logger.i('Cached ${items.length} calculations to Hive');
  }

  /// Reads from Hive and deserializes in a background isolate.
  /// Returns an empty list if cache is empty or missing.
  Future<List<RecentCalculationItemModel>> getCachedCalculations() async {
    final cached = CacheService().get<List>(_cacheKey);
    if (cached == null || cached.isEmpty) return [];
    final items = await compute(deserializeCalculations, cached);
    _logger.i('Loaded ${items.length} calculations from cache');
    return items;
  }
}
