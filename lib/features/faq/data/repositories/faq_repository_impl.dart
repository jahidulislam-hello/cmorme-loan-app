import 'package:reverse_mortage_loan_app/features/faq/data/datasources/faq_remote_datasource.dart';
import 'package:reverse_mortage_loan_app/features/faq/data/models/faq_response_model.dart';
import 'package:reverse_mortage_loan_app/features/faq/domain/repositories/faq_repository.dart';

class FaqRepositoryImpl implements FaqRepository {
  final FaqRemoteDatasource _datasource;

  FaqRepositoryImpl(this._datasource);

  @override
  Future<List<FaqItemModel>> getFaqs() => _datasource.getFaqs();
}
