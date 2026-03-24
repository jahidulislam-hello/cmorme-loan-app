import 'package:reverse_mortage_loan_app/features/faq/data/models/faq_response_model.dart';
import 'package:reverse_mortage_loan_app/features/notification/data/models/notification_model.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/data/models/recent_calculation_response_model.dart';

// All functions in this file are TOP-LEVEL — required by Flutter's compute().
// compute() runs these in a background isolate, keeping the main thread free.
// Rules: must be top-level or static, must accept exactly one argument.

// ─── Notifications ────────────────────────────────────────────────────────────
// Input  : full response.data map from the API
// Output : parsed and sorted list of NotificationModel
List<NotificationModel> parseNotifications(Map<String, dynamic> responseData) {
  final list = responseData['data']['allNoti'] as List;
  final result = list
      .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
      .toList();
  result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  return result;
}

// ─── FAQs ─────────────────────────────────────────────────────────────────────
// Input  : full response.data map from the API
// Output : parsed list of FaqItemModel
List<FaqItemModel> parseFaqs(Map<String, dynamic> responseData) {
  final list = responseData['data'] as List;
  return list
      .map((e) => FaqItemModel.fromJson(e as Map<String, dynamic>))
      .toList();
}

// ─── Recent Calculations — API response ───────────────────────────────────────
// Input  : full response.data map from the API
// Output : RecentCalculationResponseModel (parses nested list of items internally)
RecentCalculationResponseModel parseCalculationResponse(
    Map<String, dynamic> json) {
  return RecentCalculationResponseModel.fromJson(json);
}

// ─── Recent Calculations — Cache write (toJson) ───────────────────────────────
// Input  : list of model objects already in memory
// Output : list of raw Maps ready to be written to Hive
List<Map<String, dynamic>> serializeCalculations(
    List<RecentCalculationItemModel> items) {
  return items.map((e) => e.toJson()).toList();
}

// ─── Recent Calculations — Cache read (fromJson) ──────────────────────────────
// Input  : raw List from Hive (each element is a Map from the stored JSON)
// Output : parsed list of RecentCalculationItemModel
List<RecentCalculationItemModel> deserializeCalculations(List<dynamic> rawList) {
  return rawList
      .map((e) => RecentCalculationItemModel.fromJson(
            Map<String, dynamic>.from(e as Map),
          ))
      .toList();
}
