import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reverse_mortage_loan_app/config/routes/route_names.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_button.dart';

class InquirySuccessScreen extends StatelessWidget {
  const InquirySuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Request Full Proposal',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            CustomPaint(
              size: const Size(120, 120),
              painter: _ScallopedCirclePainter(color: Colors.white),
              child: const SizedBox(
                width: 120,
                height: 120,
                child: Center(
                  child: Icon(
                    Icons.check,
                    color: AppColors.green500,
                    size: 56,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'THANK YOU!',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Send your inquiry successfully',
              style: TextStyle(
                color: AppColors.hintGrey,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: CustomButton(
                text: 'Back to Home',
                onPressed: () => Get.offAllNamed(RouteNames.userHome),
                backgroundColor: AppColors.buttonBlue,
                textColor: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScallopedCirclePainter extends CustomPainter {
  final Color color;

  _ScallopedCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final baseRadius = size.width / 2;
    const scallopCount = 8;
    const scallopDepth = 6.0;

    final path = Path();
    const totalPoints = 360;
    final degreesPerScallop = 360 / scallopCount;

    for (int i = 0; i <= totalPoints; i++) {
      final angle = i * math.pi / 180;
      final scallopPhase = (i % degreesPerScallop) / degreesPerScallop;
      final offset = math.cos(scallopPhase * 2 * math.pi) * scallopDepth;
      final r = baseRadius - scallopDepth + offset;
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
