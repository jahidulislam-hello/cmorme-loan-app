import 'package:flutter/material.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class ConsentDisclaimer extends StatelessWidget {
  const ConsentDisclaimer({super.key});

  static const String _text =
      'By clicking "Submit" and sharing your contact information, you expressly '
      'consent to allow Reverse Mortgage Educators, Inc., to contact you about '
      'your inquiry, and our products, promotions, and services via phone call or '
      'text at the phone number and/or email address you provide using a manual or '
      'automated system and/or prerecorded messages, even if you are on a State or '
      'Federal Do-Not-Call list. Message and data rates may apply. You can revoke '
      'this consent any time. To speak with someone at Reverse Mortgage Educators, '
      'Inc, please call 800-800-2190.';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        _text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.hintGrey,
          fontSize: 10,
          height: 1.6,
        ),
      ),
    );
  }
}
