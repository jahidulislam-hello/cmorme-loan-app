import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/features/authentication/presentation/view/binding/auth_binding.dart';
import 'package:reverse_mortage_loan_app/features/authentication/presentation/view/choose_account_screen.dart';
import 'package:reverse_mortage_loan_app/features/authentication/presentation/view/new_password_screen.dart';
import 'package:reverse_mortage_loan_app/features/authentication/presentation/view/otp_screen.dart';
import 'package:reverse_mortage_loan_app/features/authentication/presentation/view/sign_in_screen.dart';
import 'package:reverse_mortage_loan_app/features/authentication/presentation/view/sign_up_screen.dart';
import 'package:reverse_mortage_loan_app/features/authentication/presentation/view/verify_email_screen.dart';
import 'package:reverse_mortage_loan_app/features/home/presentation/view/binding/home_binding.dart';
import 'package:reverse_mortage_loan_app/features/home/presentation/view/calculate_options_screen.dart';
import 'package:reverse_mortage_loan_app/features/home/presentation/view/splash_screen.dart';
import 'package:reverse_mortage_loan_app/features/home/presentation/view/user_home_screen.dart';
import 'package:reverse_mortage_loan_app/features/home/presentation/view/tips_calculate_screen.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/presentation/view/binding/recent_calculation_binding.dart';
import 'package:reverse_mortage_loan_app/features/recent_calculation/presentation/view/recent_calculation_screen.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/presentation/view/binding/reverse_refinance_binding.dart';
import 'package:reverse_mortage_loan_app/features/history/presentation/view/bindings/history_binding.dart';
import 'package:reverse_mortage_loan_app/features/history/presentation/view/page/history_screen.dart';
import 'package:reverse_mortage_loan_app/features/loan_details/presentation/view/bindings/loan_details_binding.dart';
import 'package:reverse_mortage_loan_app/features/loan_details/presentation/view/page/loan_details_screen.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/bindings/request_proposal_binding.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/page/request_proposal_screen.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/page/address_page.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/page/city_state_page.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/page/interested_page.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/page/loan_amount_page.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/page/dob_page.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/page/inquiry_page.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/page/appointment_page.dart';
import 'package:reverse_mortage_loan_app/features/request_proposal/presentation/view/page/inquiry_success_screen.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/presentation/view/loan_result_screen.dart';
import 'package:reverse_mortage_loan_app/features/inbox/presentation/view/binding/inbox_binding.dart';
import 'package:reverse_mortage_loan_app/features/inbox/presentation/view/page/inbox_screen.dart';
import 'package:reverse_mortage_loan_app/features/inbox/presentation/view/page/inbox_details_screen.dart';
import 'package:reverse_mortage_loan_app/features/notification/presentation/view/binding/notification_binding.dart';
import 'package:reverse_mortage_loan_app/features/notification/presentation/view/page/notification_screen.dart';
import 'package:reverse_mortage_loan_app/features/legal/presentation/view/binding/legal_binding.dart';
import 'package:reverse_mortage_loan_app/features/legal/presentation/view/page/legal_screen.dart';
import 'package:reverse_mortage_loan_app/features/profile/presentation/view/binding/profile_binding.dart';
import 'package:reverse_mortage_loan_app/features/profile/presentation/view/page/account_setting_screen.dart';
import 'package:reverse_mortage_loan_app/features/profile/presentation/view/page/edit_profile_screen.dart';
import 'package:reverse_mortage_loan_app/features/profile/presentation/view/page/setting_screen.dart';
import 'package:reverse_mortage_loan_app/features/profile/presentation/view/page/change_password_screen.dart';
import 'package:reverse_mortage_loan_app/features/reverse_refinance/presentation/view/reverse_refinance_screen.dart';

class AppRouter {
  AppRouter._();

  static final routes = [
    GetPage(
      name: RouteNames.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: RouteNames.chooseAccount,
      page: () => const ChooseAccountScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: RouteNames.signIn,
      page: () => const SignInScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: RouteNames.signUp,
      page: () => const SignUpScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: RouteNames.verifyEmail,
      page: () => const VerifyEmailScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: RouteNames.otp,
      page: () => const OtpScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: RouteNames.newPassword,
      page: () => const NewPasswordScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: RouteNames.userHome,
      page: () => const UserHomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: RouteNames.calculateOptions,
      page: () => const CalculateOptionsScreen(),
    ),
    GetPage(
      name: RouteNames.reverseRefinance,
      page: () => const ReverseRefinanceScreen(),
      binding: ReverseRefinanceBinding(),
    ),
    GetPage(
      name: RouteNames.tipsCalculate,
      page: () => const TipsCalculateScreen(),
    ),
    GetPage(
      name: RouteNames.recentCalculation,
      page: () => const RecentCalculationScreen(),
      binding: RecentCalculationBinding(),
    ),
    GetPage(
      name: RouteNames.loanResult,
      page: () => const LoanResultScreen(),
    ),
    GetPage(
      name: RouteNames.history,
      page: () => const HistoryScreen(),
      binding: HistoryBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.loanDetails,
      page: () => const LoanDetailsScreen(),
      binding: LoanDetailsBinding(),
    ),
    GetPage(
      name: RouteNames.requestProposal,
      page: () => const RequestProposalScreen(),
      binding: RequestProposalBinding(),
    ),
    GetPage(
      name: RouteNames.proposalAddress,
      page: () => const AddressPage(),
    ),
    GetPage(
      name: RouteNames.proposalCityState,
      page: () => const CityStatePage(),
    ),
    GetPage(
      name: RouteNames.proposalInterested,
      page: () => const InterestedPage(),
    ),
    GetPage(
      name: RouteNames.proposalLoanAmount,
      page: () => const LoanAmountPage(),
    ),
    GetPage(
      name: RouteNames.proposalDob,
      page: () => const DobPage(),
    ),
    GetPage(
      name: RouteNames.proposalInquiry,
      page: () => const InquiryPage(),
    ),
    GetPage(
      name: RouteNames.proposalAppointment,
      page: () => const AppointmentPage(),
    ),
    GetPage(
      name: RouteNames.inquirySuccess,
      page: () => const InquirySuccessScreen(),
    ),
    GetPage(
      name: RouteNames.accountSetting,
      page: () => const AccountSettingScreen(),
      binding: ProfileBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.editProfile,
      page: () => const EditProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: RouteNames.setting,
      page: () => const SettingScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: RouteNames.changePassword,
      page: () => const ChangePasswordScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: RouteNames.legal,
      page: () => const LegalScreen(),
      binding: LegalBinding(),
    ),
    GetPage(
      name: RouteNames.notification,
      page: () => const NotificationScreen(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: RouteNames.inbox,
      page: () => const InboxScreen(),
      binding: InboxBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: RouteNames.inboxDetails,
      page: () => const InboxDetailsScreen(),
      binding: InboxBinding(),
    ),
  ];
}
