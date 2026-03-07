import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/core/services/api_service.dart';
import 'package:reverse_mortage_loan_app/core/services/token_service.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:reverse_mortage_loan_app/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:reverse_mortage_loan_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:reverse_mortage_loan_app/features/authentication/domain/usecases/forget_password_usecase.dart';
import 'package:reverse_mortage_loan_app/features/authentication/domain/usecases/login_usecase.dart';
import 'package:reverse_mortage_loan_app/features/authentication/domain/usecases/register_usecase.dart';
import 'package:reverse_mortage_loan_app/features/authentication/domain/usecases/reset_password_usecase.dart';
import 'package:reverse_mortage_loan_app/features/authentication/domain/usecases/verify_forget_otp_usecase.dart';
import 'package:reverse_mortage_loan_app/features/authentication/domain/usecases/verify_otp_usecase.dart';
import 'package:reverse_mortage_loan_app/features/authentication/presentation/view/controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRemoteDatasource>(
      () => AuthRemoteDatasource(ApiService()),
    );
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        Get.find<AuthRemoteDatasource>(),
        TokenService(),
      ),
    );
    Get.lazyPut<RegisterUseCase>(
      () => RegisterUseCase(Get.find<AuthRepository>()),
    );
    Get.lazyPut<VerifyOtpUseCase>(
      () => VerifyOtpUseCase(Get.find<AuthRepository>()),
    );
    Get.lazyPut<LoginUseCase>(
      () => LoginUseCase(Get.find<AuthRepository>()),
    );
    Get.lazyPut<ForgetPasswordUseCase>(
      () => ForgetPasswordUseCase(Get.find<AuthRepository>()),
    );
    Get.lazyPut<VerifyForgetOtpUseCase>(
      () => VerifyForgetOtpUseCase(Get.find<AuthRepository>()),
    );
    Get.lazyPut<ResetPasswordUseCase>(
      () => ResetPasswordUseCase(Get.find<AuthRepository>()),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(
        registerUseCase: Get.find<RegisterUseCase>(),
        verifyOtpUseCase: Get.find<VerifyOtpUseCase>(),
        loginUseCase: Get.find<LoginUseCase>(),
        forgetPasswordUseCase: Get.find<ForgetPasswordUseCase>(),
        verifyForgetOtpUseCase: Get.find<VerifyForgetOtpUseCase>(),
        resetPasswordUseCase: Get.find<ResetPasswordUseCase>(),
      ),
    );
  }
}
