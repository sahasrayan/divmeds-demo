import 'package:divmeds/designs/app_colors.dart';
import 'package:divmeds/features/auth/models/dummy_list.dart';
import 'package:divmeds/features/messaging/ui/convsersation_screen.dart';
import 'package:divmeds/utils/feature_not_available_screen.dart';
import 'package:flutter/material.dart';

class MessagingScreen extends StatelessWidget {
  const MessagingScreen({super.key});

  @override
  Widget build(BuildContext context) {
return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
        backgroundColor: AppColors.divMedsColorBlueScaffoldAccent,
      ),
      body: ListView.builder(
        itemCount: dummyUsers.length,
        itemBuilder: (context, index) {
          final user = dummyUsers[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.profilePicture),
            ),
            title: Text('${user.firstName} ${user.lastName}'),
            subtitle: Text('Tap to view conversation'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConversationScreen(user: user),
                ),
              );
            },
          );
        },
      ),
    );
  }
}