import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  final String assetPath;
  final double height;

  const Logo._({super.key, required this.assetPath, this.height = 80.0});

  // Colour Logo
  const Logo.colour({Key? key, double height = 80.0})
      : this._(key: key, assetPath: 'assets/icons/nirlipta-logo.svg', height: height);

  // White Logo
  const Logo.white({Key? key, double height = 80.0})
      : this._(key: key, assetPath: 'assets/icons/nirlipta-logo-white.svg', height: height);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        assetPath,
        height: height,
      ),
    );
  }
}
