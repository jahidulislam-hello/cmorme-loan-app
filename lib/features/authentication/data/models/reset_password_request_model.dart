class ResetPasswordRequestModel {
  final String password;
  final String confirmPassword;

  ResetPasswordRequestModel({
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
        'password': password,
        'confirmPassword': confirmPassword,
      };
}
