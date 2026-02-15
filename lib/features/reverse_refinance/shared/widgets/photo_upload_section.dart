import 'dart:io';
import 'package:flutter/material.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class PhotoUploadSection extends StatelessWidget {
  final List<File> photos;
  final int currentPhotoIndex;
  final VoidCallback onUploadTap;
  final ValueChanged<int>? onPageChanged;
  final int maxPhotos;

  const PhotoUploadSection({
    super.key,
    required this.photos,
    this.currentPhotoIndex = 0,
    required this.onUploadTap,
    this.onPageChanged,
    this.maxPhotos = 10,
  });

  @override
  Widget build(BuildContext context) {
    if (photos.isEmpty) {
      return _buildUploadPlaceholder();
    }
    return _buildPhotoCarousel();
  }

  Widget _buildUploadPlaceholder() {
    return GestureDetector(
      onTap: onUploadTap,
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: AppColors.fieldBorder,
          strokeWidth: 1.5,
          radius: 12,
        ),
        child: SizedBox(
          width: 125,
          height: 104,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.upload_file,
                color: AppColors.hintGrey,
                size: 36,
              ),
              const SizedBox(height: 8),
              Text(
                'Upload $maxPhotos Photos',
                style: const TextStyle(
                  color: AppColors.hintGrey,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoCarousel() {
    return SizedBox(
        width: double.infinity,
        height: 180,
        child: Stack(
          children: [
            PageView.builder(
              itemCount: photos.length,
              onPageChanged: onPageChanged,
              itemBuilder: (context, index) {
                return Image.file(
                  photos[index],
                  fit: BoxFit.fill,
                  width: double.infinity,
                );
              },
            ),
            if (photos.length > 1)
              Positioned(
                left: 0,
                right: 0,
                bottom: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(photos.length, (index) {
                    return Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == currentPhotoIndex
                            ? AppColors.white
                            : AppColors.primary,
                      ),
                    );
                  }),
                ),
              ),
          ],
        ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double radius;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(radius),
      ));

    const dashWidth = 8.0;
    const dashSpace = 5.0;

    final pathMetrics = path.computeMetrics();
    for (final metric in pathMetrics) {
      double distance = 0;
      while (distance < metric.length) {
        final end = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, end.clamp(0, metric.length)),
          paint,
        );
        distance = end + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
