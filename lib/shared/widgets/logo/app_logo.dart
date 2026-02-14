import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double width;
  final double height;

  const AppLogo({
    super.key,
    this.width = 120,
    this.height = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/dummy_logo_image.png',
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }
}
