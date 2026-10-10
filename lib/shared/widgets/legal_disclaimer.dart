import 'package:flutter/material.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class LegalDisclaimer extends StatelessWidget {
  const LegalDisclaimer({super.key});

  static const String _text =
      'To keep the mortgage in good standing, the borrower must pay their '
      'property taxes, homeowner\'s insurance, HOA dues, maintain the home at '
      'FHA standards, keep the home as their primary residence, and follow the '
      'guidelines as outlined in the note. Reverse Mortgage Educators is not '
      'affiliated with any government agency. A Reverse Mortgage is a loan that, '
      'if no payments are made over time, can have an increasing balance and gets '
      'repaid when the home is sold. Not all applicants may qualify. Real Estate '
      'Broker - CA Department of Real Estate - LIC #01932729 - NMLS #1064287  |  '
      'This material is not from HUD or FHA and has not been approved by HUD or '
      'a government agency.';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
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
