import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20outsider/components/profile_back.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20outsider/components/profile_front.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:divmeds/features/auth/models/user.model.dart';

class ProfileOutsiderHeader extends StatelessWidget {
  final User user;
  final String loggedInUserId;

  const ProfileOutsiderHeader({
    super.key,
    required this.user,
    required this.loggedInUserId, // Add this parameter
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        front: OutsiderProfileFront(
          user: user,
          loggedInUserId: loggedInUserId, // Pass it here
        ),
        back: OutsiderProfileBack(user: user),
      ),
    );
  }
}
