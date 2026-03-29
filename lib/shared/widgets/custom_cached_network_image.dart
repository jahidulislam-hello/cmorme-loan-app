import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reverse_mortage_loan_app/shared/widgets/custom_shimmer_loading_indicator.dart';

/// A wrapper around [CachedNetworkImage] that provides consistent loading and
/// error states across the app. Images are cached on disk after the first load —
/// subsequent views do not re-download from the network.
class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;

  /// Shown while the image loads for the first time.
  /// Defaults to [LoanImageShimmer] if not provided.
  final Widget? placeholder;

  /// Shown when the image fails to load.
  /// Defaults to a broken image icon if not provided.
  final Widget? errorWidget;

  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: width,
      height: height,
      placeholder: (context, url) =>
          placeholder ?? const LoanImageShimmer(),
      errorWidget: (context, url, error) =>
          errorWidget ??
          const Center(
            child: Icon(
              Icons.broken_image,
              color: Colors.white54,
              size: 48,
            ),
          ),
    );
  }
}
