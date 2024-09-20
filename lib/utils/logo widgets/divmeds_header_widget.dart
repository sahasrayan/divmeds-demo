import 'package:divmeds/designs/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DivMedsHeaderLogo extends StatelessWidget {
  const DivMedsHeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
     
      child: SvgPicture.asset(AppImages.mainBlueLogoSVG),
    );
  }
}