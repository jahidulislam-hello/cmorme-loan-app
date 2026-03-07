import 'dart:io';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:reverse_mortage_loan_app/core/constants/api_constants.dart';
import 'package:reverse_mortage_loan_app/core/services/api_service.dart';
import '../models/calculate_loan_request_model.dart';
import '../models/calculate_loan_response_model.dart';
import '../models/file_upload_response_model.dart';

class ReverseRefinanceRemoteDatasource {
  final ApiService _apiService;
  final _logger = Logger();

  ReverseRefinanceRemoteDatasource(this._apiService);

  Future<FileUploadResponseModel> uploadFile(File file) async {
    _logger.d('UploadFile: ${file.path}');
    final fileName = file.path.split('/').last.split('\\').last;
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });
    final response = await _apiService.post(
      ApiConstants.fileUpload,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
    _logger.d('UploadFile raw response: ${response.data}');
    return FileUploadResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<CalculateLoanResponseModel> calculateLoan(
      CalculateLoanRequestModel request) async {
    _logger.d('CalculateLoan request body: ${request.toJson()}');
    final response = await _apiService.post(
      ApiConstants.calculateLoan,
      data: request.toJson(),
    );
    _logger.d('CalculateLoan raw response: ${response.data}');
    return CalculateLoanResponseModel.fromJson(
        response.data as Map<String, dynamic>);
  }
}
