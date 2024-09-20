import 'package:flutter/material.dart';

class VerifyYourSelfButton extends StatelessWidget {
  const VerifyYourSelfButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        
      ),
      width: double.infinity,
      child: TextButton(
        onPressed: () {
           ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("This feature will shortly be available!"),),
        );
          
        },
        child: const Text('Verify Yourself'),
      ),
    );
  }
}