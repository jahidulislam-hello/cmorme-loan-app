import 'package:reverse_mortage_loan_app/features/legal/data/datasources/legal_remote_datasource.dart';
import 'package:reverse_mortage_loan_app/features/legal/data/models/legal_response_model.dart';
import 'package:reverse_mortage_loan_app/features/legal/domain/repositories/legal_repository.dart';

class LegalRepositoryImpl implements LegalRepository {
  final LegalRemoteDatasource _datasource;

  LegalRepositoryImpl(this._datasource);

  @override
  Future<LegalResponseModel> getLegalContent(String endpoint) =>
      _datasource.getLegalContent(endpoint);
}
