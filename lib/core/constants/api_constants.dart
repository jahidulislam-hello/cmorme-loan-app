class ApiConstants {
  static const String baseUrl = 'https://sayedsabbir2000.sobhoy.com/api/v1';

  // Auth
  static const String register = '/user/register';
  static const String verifyOtp = '/user/verify-otp';
  static const String login = '/user/login';
  static const String forgetPassword = '/user/forget-password';
  static const String verifyForgetOtp = '/user/verify-forget-otp';
  static const String resetPassword = '/user/reset-password';

  // Profile
  static const String myProfile = '/user/my-profile';
  static const String updateProfile = '/user/update';
  static const String changePassword = '/user/change-password';

  // Calculate Loan
  static const String fileUpload = '/file-upload';
  static const String calculateLoan = '/calculate-loan/create';

  static Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
}
