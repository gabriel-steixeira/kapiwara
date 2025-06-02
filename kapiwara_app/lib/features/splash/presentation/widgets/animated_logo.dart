import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedLogo extends StatelessWidget {
  final String assetPath;
  final double width;
  final double height;
  final bool isSvg;
  
  const AnimatedLogo({
    super.key,
    required this.assetPath,
    this.width = 150,
    this.height = 150,
    this.isSvg = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isSvg) {
      return SvgPicture.asset(
        assetPath,
        width: width,
        height: height,
        fit: BoxFit.contain,
      );
    } else {
      return Image.asset(
        assetPath,
        width: width,
        height: height,
        fit: BoxFit.contain,
      );
    }
  }
} 