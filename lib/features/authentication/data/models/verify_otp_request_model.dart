class VerifyOtpRequestModel {
  final String otp;

  VerifyOtpRequestModel({required this.otp});

  Map<String, dynamic> toJson() => {'otp': otp};
}
