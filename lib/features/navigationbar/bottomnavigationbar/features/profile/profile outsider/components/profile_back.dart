import 'package:divmeds/designs/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:divmeds/features/auth/models/user.model.dart';

class OutsiderProfileBack extends StatelessWidget {
  final User user;

  const OutsiderProfileBack({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: AppColors.divMedsColorWhite,
      elevation: 5,
      child: Container(
        width: 350,
        height: 350,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(user.profilePicture.isNotEmpty 
                  ? user.profilePicture 
                  : 'https://via.placeholder.com/150'), // Placeholder image URL
                onBackgroundImageError: (_, __) {
                  // In case the image URL is invalid or the image fails to load
                  // You can handle it here to show a default placeholder image
                },
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                '${user.firstName} ${user.lastName}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            if (user.education.isNotEmpty) ...[
              RichText(
                text: TextSpan(
                  text: user.education[0].institution,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${user.education[0].startYear}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${user.education[0].endYear}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ] else
              Center(
                child: Text(
                  'No education details available',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
