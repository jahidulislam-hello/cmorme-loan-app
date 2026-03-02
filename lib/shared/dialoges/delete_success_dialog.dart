import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class DeleteSuccessDialog extends StatelessWidget {
  const DeleteSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.containerHighlight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Close Button
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: 28,
                height: 28,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.hintGrey,
                    size: 20,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            /// Success Badge - Scalloped Circle
            CustomPaint(
              size: const Size(64, 64),
              painter: _ScallopedCirclePainter(
                color: AppColors.white,
              ),
              child: const SizedBox(
                width: 64,
                height: 64,
                child: Center(
                  child: Icon(
                    Icons.check,
                    color: AppColors.green500,
                    size: 32,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Title
            const Text(
              'Delete!',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            /// Subtitle
            const Text(
              'Deleted your data successfully',
              style: TextStyle(
                color: AppColors.hintGrey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 16),
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
    const scallopCount = 10;
    const scallopDepth = 3.0;

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
