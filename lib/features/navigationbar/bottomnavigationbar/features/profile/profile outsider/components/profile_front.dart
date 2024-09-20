import 'package:divmeds/core/api/api.url.dart';
import 'package:divmeds/designs/app_colors.dart';
import 'package:divmeds/features/connections/ui/connection_screen.dart';
import 'package:divmeds/utils/feature_not_available_screen.dart';
import 'package:flutter/material.dart';
import 'package:divmeds/features/auth/models/user.model.dart';

class OutsiderProfileFront extends StatelessWidget {
  final User user;
  final String loggedInUserId; // Add loggedInUserId

  const OutsiderProfileFront({
    super.key,
    required this.user,
    required this.loggedInUserId, // Add loggedInUserId
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
                  // Handle image error
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  user.education.isNotEmpty
                      ? user.education[0].degree
                      : 'No degree available',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Text(
                //   user.education.isNotEmpty
                //       ? user.education[0].currentYear
                //       : 'No current year',
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConnectionListScreen(
                              serverUrl: Config.serverUrl,
                              token: Config.token,
                              loggedInUserId: loggedInUserId, // Use loggedInUserId for logging purposes
                              userId: user.userId, // Pass searched user's userId
                            ),
                          ),
                        );
                      },
                      child: Text(
                        '${user.connections.length}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      'Connections',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ComingSoonScreen(
                              backGroundColor: AppColors.divMedsColorBlueScaffoldBackground,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        '0', // Replace with actual score if available
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      'Score',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
