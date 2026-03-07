import 'dart:io';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/data/models/calculate_loan_request_model.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/data/models/calculate_loan_response_model.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/data/models/file_upload_response_model.dart';

abstract class ReverseRefinanceRepository {
  Future<FileUploadResponseModel> uploadFile(File file);
  Future<CalculateLoanResponseModel> calculateLoan(CalculateLoanRequestModel request);
}
