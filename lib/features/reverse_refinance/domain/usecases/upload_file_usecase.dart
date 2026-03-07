import 'dart:io';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/data/models/file_upload_response_model.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/domain/repositories/reverse_refinance_repository.dart';

class UploadFileUseCase {
  final ReverseRefinanceRepository _repository;

  UploadFileUseCase(this._repository);

  Future<FileUploadResponseModel> call(File file) async {
    return await _repository.uploadFile(file);
  }
}
