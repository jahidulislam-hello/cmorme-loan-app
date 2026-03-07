import 'dart:io';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/data/datasources/reverse_refinance_remote_datasource.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/data/models/calculate_loan_request_model.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/data/models/calculate_loan_response_model.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/data/models/file_upload_response_model.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/domain/repositories/reverse_refinance_repository.dart';

class ReverseRefinanceRepositoryImpl implements ReverseRefinanceRepository {
  final ReverseRefinanceRemoteDatasource _datasource;

  ReverseRefinanceRepositoryImpl(this._datasource);

  @override
  Future<FileUploadResponseModel> uploadFile(File file) async {
    return await _datasource.uploadFile(file);
  }

  @override
  Future<CalculateLoanResponseModel> calculateLoan(
      CalculateLoanRequestModel request) async {
    return await _datasource.calculateLoan(request);
  }
}
