import 'package:divmeds/designs/app_images.dart';
import 'package:flutter/material.dart';

class WhiteLogoWidget extends StatelessWidget {
  const WhiteLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height:100,
      child: Image.asset(AppImages.whiteLogoPNG),
    );
  }
}