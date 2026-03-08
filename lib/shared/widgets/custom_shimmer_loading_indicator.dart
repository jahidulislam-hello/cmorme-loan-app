import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:reverse_mortage_loan_app/shared/theme/app_colors.dart';

class CustomShimmerLoadingIndicator extends StatelessWidget {
  final int itemCount;

  const CustomShimmerLoadingIndicator({super.key, this.itemCount = 3});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      physics: const BouncingScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (_, __) => const CustomCalculationItemShimmer(),
    );
  }
}

/// A single shimmer card that mirrors [CustomCalculationItem].
/// Use this for one-off placements (e.g. home screen).
/// [CustomShimmerLoadingIndicator] uses this internally for list loading.
class CustomCalculationItemShimmer extends StatelessWidget {
  const CustomCalculationItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF2D4278),
      highlightColor: const Color(0xFF3D5A9A),
      child: const _CalculationItemSkeleton(),
    );
  }
}

class _CalculationItemSkeleton extends StatelessWidget {
  const _CalculationItemSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.containerHighlight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Row 1: date icon + date text | tag badge ──────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _ShimmerBox(width: 16, height: 16, borderRadius: 4),
                  const SizedBox(width: 6),
                  _ShimmerBox(width: 100, height: 14, borderRadius: 4),
                ],
              ),
              _ShimmerBox(width: 80, height: 22, borderRadius: 4),
            ],
          ),
          const SizedBox(height: 16),

          // ── Row 2: Loan Amount | Cash Available ────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Loan Amount column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _ShimmerBox(width: 14, height: 14, borderRadius: 4),
                      const SizedBox(width: 4),
                      _ShimmerBox(width: 80, height: 13, borderRadius: 4),
                    ],
                  ),
                  const SizedBox(height: 4),
                  _ShimmerBox(width: 80, height: 20, borderRadius: 4),
                ],
              ),
              // Cash Available column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _ShimmerBox(width: 14, height: 14, borderRadius: 4),
                      const SizedBox(width: 4),
                      _ShimmerBox(width: 90, height: 13, borderRadius: 4),
                    ],
                  ),
                  const SizedBox(height: 4),
                  _ShimmerBox(width: 80, height: 20, borderRadius: 4),
                ],
              ),
              // Down Payment column placeholder (keeps layout balanced)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _ShimmerBox(width: 14, height: 14, borderRadius: 4),
                      const SizedBox(width: 4),
                      _ShimmerBox(width: 60, height: 13, borderRadius: 4),
                    ],
                  ),
                  const SizedBox(height: 4),
                  _ShimmerBox(width: 60, height: 20, borderRadius: 4),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ── Divider ────────────────────────────────────────────────────────
          _ShimmerBox(width: double.infinity, height: 2, borderRadius: 2),
          const SizedBox(height: 16),

          // ── Row 3: View Details | Delete button ────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ShimmerBox(width: 80, height: 13, borderRadius: 4),
              _ShimmerBox(width: 20, height: 20, borderRadius: 5),
            ],
          ),
        ],
      ),
    );
  }
}

/// Shimmer placeholder for a network image inside [LoanImageSection].
/// Matches the 200px height and borderRadius 4 of the image container.
class LoanImageShimmer extends StatelessWidget {
  const LoanImageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF2D4278),
      highlightColor: const Color(0xFF3D5A9A),
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: const Color(0xFF2D4278),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}

/// Shimmer placeholder for the LegalScreen HTML content.
/// Mimics a document with headings and paragraph lines.
class LegalContentShimmer extends StatelessWidget {
  const LegalContentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF2D4278),
      highlightColor: const Color(0xFF3D5A9A),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            _ShimmerBox(width: 200, height: 22, borderRadius: 4),
            const SizedBox(height: 16),

            // Paragraph block 1
            ..._paragraphLines([0.9, 1.0, 0.85, 0.7]),
            const SizedBox(height: 20),

            // Sub-heading
            _ShimmerBox(width: 160, height: 18, borderRadius: 4),
            const SizedBox(height: 12),

            // Paragraph block 2
            ..._paragraphLines([1.0, 0.95, 0.8, 0.6]),
            const SizedBox(height: 20),

            // Sub-heading
            _ShimmerBox(width: 140, height: 18, borderRadius: 4),
            const SizedBox(height: 12),

            // Paragraph block 3
            ..._paragraphLines([0.95, 1.0, 0.75]),
            const SizedBox(height: 20),

            // Sub-heading
            _ShimmerBox(width: 170, height: 18, borderRadius: 4),
            const SizedBox(height: 12),

            // Paragraph block 4
            ..._paragraphLines([1.0, 0.9, 0.85, 0.5]),
            const SizedBox(height: 20),

            // Sub-heading
            _ShimmerBox(width: 150, height: 18, borderRadius: 4),
            const SizedBox(height: 12),

            // Paragraph block 5
            ..._paragraphLines([0.9, 0.8, 0.65]),
          ],
        ),
      ),
    );
  }

  List<Widget> _paragraphLines(List<double> fractions) {
    final screenWidth = 360.0; // approximate inner width
    final widgets = <Widget>[];
    for (final f in fractions) {
      widgets.add(_ShimmerBox(
        width: screenWidth * f,
        height: 14,
        borderRadius: 4,
      ));
      widgets.add(const SizedBox(height: 8));
    }
    return widgets;
  }
}

class _ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const _ShimmerBox({
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF2D4278),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
