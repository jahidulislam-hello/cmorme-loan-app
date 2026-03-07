class RegisterRequestModel {
  final String firstName;
  final String email;
  final String password;
  final String confirmPassword;

  RegisterRequestModel({
    required this.firstName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      };
}
