import 'package:reverse_mortage_loan_app/features/profile/data/models/change_password_request_model.dart';
import 'package:reverse_mortage_loan_app/features/profile/data/models/change_password_response_model.dart';
import 'package:reverse_mortage_loan_app/features/profile/data/models/profile_model.dart';
import 'package:reverse_mortage_loan_app/features/profile/data/models/update_profile_request_model.dart';
import 'package:reverse_mortage_loan_app/features/profile/data/models/update_profile_response_model.dart';

abstract class ProfileRepository {
  Future<ProfileModel> getProfile();
  Future<UpdateProfileResponseModel> updateProfile(UpdateProfileRequestModel request);
  Future<ChangePasswordResponseModel> changePassword(ChangePasswordRequestModel request);
  Future<void> deleteAccount(String id);
}
