import 'package:reverse_mortage_loan_app/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:reverse_mortage_loan_app/features/profile/data/models/change_password_request_model.dart';
import 'package:reverse_mortage_loan_app/features/profile/data/models/change_password_response_model.dart';
import 'package:reverse_mortage_loan_app/features/profile/data/models/profile_model.dart';
import 'package:reverse_mortage_loan_app/features/profile/data/models/update_profile_request_model.dart';
import 'package:reverse_mortage_loan_app/features/profile/data/models/update_profile_response_model.dart';
import 'package:reverse_mortage_loan_app/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource _datasource;

  ProfileRepositoryImpl(this._datasource);

  @override
  Future<ProfileModel> getProfile() async {
    return await _datasource.getProfile();
  }

  @override
  Future<UpdateProfileResponseModel> updateProfile(UpdateProfileRequestModel request) async {
    return await _datasource.updateProfile(request);
  }

  @override
  Future<ChangePasswordResponseModel> changePassword(ChangePasswordRequestModel request) async {
    return await _datasource.changePassword(request);
  }

  @override
  Future<void> deleteAccount(String id) async {
    return await _datasource.deleteAccount(id);
  }
}
