import 'package:divmeds/designs/app_colors.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/explore/components/input_button.dart';
import 'package:flutter/material.dart';

class DiscussionSection extends StatelessWidget {
  const DiscussionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1, // Replace with actual discussion count
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColors.divMedsColorBlueScaffoldAccent,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                color: AppColors.divMedsColorBabyBlue,
                size: 48.0,
              ),
              SizedBox(height: 16.0),
              Text(
                'Feature Unavailable',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'As DivMeds is in the MVP development stage, this feature is currently not available. Help us in reaching more healthcare peers to make DivMeds even better!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16.0),
              InputButtonWithShareIcon(
                onPressed: () {
                  print("Hi");
                },
              ),
            ],
          ),
        );
      },
    );
  }
}