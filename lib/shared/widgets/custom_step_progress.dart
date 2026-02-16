import 'package:flutter/material.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class CustomStepProgress extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final ValueChanged<int>? onStepTap;

  const CustomStepProgress({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    this.onStepTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps * 2 - 1, (index) {
        if (index.isEven) {
          final stepIndex = index ~/ 2;
          final isActive = stepIndex == currentStep;

          if (isActive) {
            return _buildActiveCircle(stepIndex);
          }

          return GestureDetector(
            onTap: stepIndex < currentStep
                ? () => onStepTap?.call(stepIndex)
                : null,
            child: _buildInactiveCircle(stepIndex),
          );
        } else {
          return Expanded(
            child: CustomPaint(
              painter: _DottedLinePainter(
                color: AppColors.hintGrey.withValues(alpha: 0.4),
              ),
              child: const SizedBox(height: 2),
            ),
          );
        }
      }),
    );
  }

  Widget _buildActiveCircle(int stepIndex) {
    return SizedBox(
      width: 36,
      height: 36,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.yellow500,
            ),
          ),
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
            ),
          ),
          Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.yellow500,
            ),
            child: Center(
              child: Text(
                '${stepIndex + 1}',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInactiveCircle(int stepIndex) {
    final isCompleted = stepIndex < currentStep;

    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted
            ? AppColors.containerHighlight
            : AppColors.hintGrey.withValues(alpha: 0.4),
      ),
      child: Center(
        child: Text(
          '${stepIndex + 1}',
          style: const TextStyle(
            color: AppColors.blue200,
            fontSize: 9,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final Color color;

  _DottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    const dashWidth = 4.0;
    const dashSpace = 4.0;
    double startX = 0;
    final y = size.height / 2;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, y),
        Offset(startX + dashWidth, y),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
