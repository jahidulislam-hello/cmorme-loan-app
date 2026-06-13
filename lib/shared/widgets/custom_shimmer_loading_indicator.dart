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
              Flexible(
                child: Row(
                  children: [
                    const _ShimmerBox(width: 16, height: 16, borderRadius: 4),
                    const SizedBox(width: 6),
                    const _ShimmerBox(width: 100, height: 14, borderRadius: 4),
                  ],
                ),
              ),
              const _ShimmerBox(width: 80, height: 22, borderRadius: 4),
            ],
          ),
          const SizedBox(height: 16),

          // ── Row 2: Loan Amount | Cash Available ────────────────────────────
          Row(
            children: [
              // Loan Amount column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const _ShimmerBox(width: 14, height: 14, borderRadius: 4),
                        const SizedBox(width: 4),
                        const Expanded(
                          child: _ShimmerBox(
                              width: double.infinity,
                              height: 13,
                              borderRadius: 4),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const _ShimmerBox(width: 80, height: 20, borderRadius: 4),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Cash Available column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const _ShimmerBox(width: 14, height: 14, borderRadius: 4),
                        const SizedBox(width: 4),
                        const Expanded(
                          child: _ShimmerBox(
                              width: double.infinity,
                              height: 13,
                              borderRadius: 4),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const _ShimmerBox(width: 80, height: 20, borderRadius: 4),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Down Payment column placeholder (keeps layout balanced)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const _ShimmerBox(width: 14, height: 14, borderRadius: 4),
                        const SizedBox(width: 4),
                        const Expanded(
                          child: _ShimmerBox(
                              width: double.infinity,
                              height: 13,
                              borderRadius: 4),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const _ShimmerBox(width: 60, height: 20, borderRadius: 4),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ── Divider ────────────────────────────────────────────────────────
          const _ShimmerBox(width: double.infinity, height: 2, borderRadius: 2),
          const SizedBox(height: 16),

          // ── Row 3: View Details | Delete button ────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const _ShimmerBox(width: 80, height: 13, borderRadius: 4),
              const _ShimmerBox(width: 20, height: 20, borderRadius: 5),
            ],
          ),
        ],
      ),
    );
  }
}

/// Shimmer placeholder for the photo upload area in [ReverseRefinanceScreen].
/// Covers the full-width photo container (180px height) while images are uploading.
class PhotoUploadShimmer extends StatelessWidget {
  const PhotoUploadShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF2D4278),
      highlightColor: const Color(0xFF3D5A9A),
      child: Container(
        width: double.infinity,
        height: 180,
        color: const Color(0xFF2D4278),
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Heading
                _ShimmerBox(width: w * 0.6, height: 22, borderRadius: 4),
                const SizedBox(height: 16),

                // Paragraph block 1
                ..._paragraphLines(w, [0.9, 1.0, 0.85, 0.7]),
                const SizedBox(height: 20),

                // Sub-heading
                _ShimmerBox(width: w * 0.45, height: 18, borderRadius: 4),
                const SizedBox(height: 12),

                // Paragraph block 2
                ..._paragraphLines(w, [1.0, 0.95, 0.8, 0.6]),
                const SizedBox(height: 20),

                // Sub-heading
                _ShimmerBox(width: w * 0.4, height: 18, borderRadius: 4),
                const SizedBox(height: 12),

                // Paragraph block 3
                ..._paragraphLines(w, [0.95, 1.0, 0.75]),
                const SizedBox(height: 20),

                // Sub-heading
                _ShimmerBox(width: w * 0.48, height: 18, borderRadius: 4),
                const SizedBox(height: 12),

                // Paragraph block 4
                ..._paragraphLines(w, [1.0, 0.9, 0.85, 0.5]),
                const SizedBox(height: 20),

                // Sub-heading
                _ShimmerBox(width: w * 0.42, height: 18, borderRadius: 4),
                const SizedBox(height: 12),

                // Paragraph block 5
                ..._paragraphLines(w, [0.9, 0.8, 0.65]),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _paragraphLines(double totalWidth, List<double> fractions) {
    final widgets = <Widget>[];
    for (final f in fractions) {
      widgets.add(_ShimmerBox(
        width: totalWidth * f,
        height: 14,
        borderRadius: 4,
      ));
      widgets.add(const SizedBox(height: 8));
    }
    return widgets;
  }
}

/// Shimmer placeholder for the FAQ screen.
/// Mirrors [FaqItemWidget]: rounded container with a "Q:" prefix placeholder,
/// a question text line, and a chevron icon placeholder on the right.
class FaqItemShimmer extends StatelessWidget {
  final int itemCount;

  const FaqItemShimmer({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (_, __) => Shimmer.fromColors(
        baseColor: const Color(0xFF2D4278),
        highlightColor: const Color(0xFF3D5A9A),
        child: const _FaqItemSkeleton(),
      ),
    );
  }
}

class _FaqItemSkeleton extends StatelessWidget {
  const _FaqItemSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.containerHighlight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // "Q:" prefix placeholder
          _ShimmerBox(width: 20, height: 14, borderRadius: 4),
          const SizedBox(width: 8),
          // Question text placeholder
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ShimmerBox(width: double.infinity, height: 14, borderRadius: 4),
                const SizedBox(height: 6),
                _ShimmerBox(width: 200, height: 14, borderRadius: 4),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Chevron icon placeholder
          _ShimmerBox(width: 22, height: 22, borderRadius: 4),
        ],
      ),
    );
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
