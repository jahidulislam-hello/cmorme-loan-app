class ApiConstants {
  static const String baseUrl = 'https://sayedsabbir2000.sobhoy.com/api/v1';
  static const String imageBaseUrl = 'http://sayedsabbir2000.sobhoy.com';

  // Auth
  static const String register = '/user/register';
  static const String verifyOtp = '/user/verify-otp';
  static const String login = '/user/login';
  static const String forgetPassword = '/user/forget-password';
  static const String verifyForgetOtp = '/user/verify-forget-otp';
  static const String resetPassword = '/user/reset-password';
  static const String resendOtp = '/user/resend';

  // Profile
  static const String myProfile = '/user/my-profile';
  static const String updateProfile = '/user/update';
  static const String changePassword = '/user/change-password';

  // Management
  static const String legalPrivacy = '/management/privacy';
  static const String legalAbout = '/management/about';
  static const String legalTerms = '/management/terms';

  // Request Proposal
  static const String requestProposalCreate = '/request-proposal/create';
  static const String requestProposalUpdate = '/request-proposal';
  static const String requestProposalMy = '/request-proposal/my';

  // Notifications
  static const String myNotifications = '/notification/my';

  // Calculate Loan
  static const String fileUpload = '/file-upload';
  static const String calculateLoan = '/calculate-loan/create';
  static const String calculateLoanAll = '/calculate-loan/all';
  static const String calculateLoanById = '/calculate-loan';
  static const String calculateLoanDelete = '/calculate-loan';

  static Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
}
