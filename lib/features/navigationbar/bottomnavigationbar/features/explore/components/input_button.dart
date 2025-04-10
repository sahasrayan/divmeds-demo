import 'package:divmeds/designs/app_colors.dart';
import 'package:flutter/material.dart';

class InputButtonWithShareIcon extends StatelessWidget {
  // Function onPressed can not be used here.
  final VoidCallback onPressed;

  const InputButtonWithShareIcon({
    super.key,
    required this.onPressed,
     

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.grey[200],
        ),
        child: Icon(
          Icons.share_sharp,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
