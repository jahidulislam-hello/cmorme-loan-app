import 'package:reverse_mortage_loan_app/features/did_you_know/data/datasources/did_you_know_remote_datasource.dart';
import 'package:reverse_mortage_loan_app/features/did_you_know/domain/repositories/did_you_know_repository.dart';

class DidYouKnowRepositoryImpl implements DidYouKnowRepository {
  final DidYouKnowRemoteDatasource _datasource;

  DidYouKnowRepositoryImpl(this._datasource);

  @override
  Future<List<String>> getDidYouKnow() async {
    final response = await _datasource.getDidYouKnow();
    return response.tips;
  }
}
