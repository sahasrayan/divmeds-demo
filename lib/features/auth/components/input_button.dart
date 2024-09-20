import 'package:divmeds/designs/app_colors.dart';
import 'package:flutter/material.dart';

class InputButton extends StatelessWidget {
  // Function onPressed can not be used here.
  final VoidCallback onPressed;
  final String buttonName;
  const InputButton({
    super.key,
    required this.onPressed,
    required this.buttonName,
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
        child: Text(
          buttonName,
          style: const TextStyle(
            fontSize: 18,
            color: AppColors.divMedsColorBlue3,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
