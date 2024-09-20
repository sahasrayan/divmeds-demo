import 'dart:async';
import 'package:divmeds/core/api/api.url.dart';
import 'package:divmeds/core/db/local/sharepreferencesmanager.dart';
import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/bottomnavigationbar.dart';
import 'package:divmeds/features/onboarding/ui/onboarding_screen.dart';
import 'package:flutter/material.dart';


class DecidePage extends StatefulWidget {
  static StreamController<User?> authStream = StreamController.broadcast();
  const DecidePage({super.key});

  @override
  State<DecidePage> createState() => _DecidePageState();
}

class _DecidePageState extends State<DecidePage> {
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    String uid = SharedPreferencesManager.getUid();
    User? user = SharedPreferencesManager.getUser();
    String token = SharedPreferencesManager.getToken();

    if (uid.isEmpty || user == null || token.isEmpty) {
      DecidePage.authStream.add(null);
    } else {
      Config.token = token;
      DecidePage.authStream.add(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: DecidePage.authStream.stream,
      builder: (context, snapshot) {
         if (snapshot.data == null) {
          return const OnboardingScreen();
                 
        } else {
          // return BottomNavigationBarItems(user: snapshot.data!);
                return const OnboardingScreen();
        }
      },
    );
  }

  @override
  void dispose() {
    DecidePage.authStream.close();
    super.dispose();
  }
}
