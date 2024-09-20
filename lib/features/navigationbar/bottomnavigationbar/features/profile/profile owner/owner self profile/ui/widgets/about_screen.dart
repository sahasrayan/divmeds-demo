import 'package:divmeds/core/api/api.url.dart';
import 'package:divmeds/core/db/local/sharepreferencesmanager.dart';
import 'package:divmeds/features/auth/repositories/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/ui/widgets/add_education_screen.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/ui/widgets/add_experience_screen.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/ui/widgets/edit_profile_screen.dart';
import 'package:divmeds/features/navigationbar/bottomnavigationbar/features/profile/profile%20owner/owner%20self%20profile/verification/bloc/profile_verification_bloc.dart';

class AboutScreen extends StatefulWidget {
  final User user;

  const AboutScreen({
    super.key,
    required this.user,
  });

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  late Future<List<Education>?> _userEducation;
  late Future<List<ProfessionalDetails>?> _userExperience;

  @override
  void initState() {
    super.initState();
    _loadUserEducation();
    _loadUserExperience();
  }

  void _loadUserEducation() {
    final token = SharedPreferencesManager.getToken();
    if (token != null && token.isNotEmpty) {
      setState(() {
        _userEducation = UserRepository(serverUrl: Config.serverUrl).getUserEducation(token);
      });
    } else {
      _userEducation = Future.value(null);
    }
  }

  void _loadUserExperience() {
    final token = SharedPreferencesManager.getToken();
    if (token != null && token.isNotEmpty) {
      setState(() {
        _userExperience = UserRepository(serverUrl: Config.serverUrl).getUserProfession(token);
      });
    } else {
      _userExperience = Future.value(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        children: [
          _buildAboutTab(context),
         
        ],
      ),
    );
  }

  Widget _buildAboutTab(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Education'),
              trailing: Icon(Icons.edit),
              onTap: () {
                // Navigate to add education screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddEducationScreen(user: widget.user)),
                );
              },
            ),
            FutureBuilder<List<Education>?>(
              future: _userEducation,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final education = snapshot.data!;
                  // Take the latest entry
                  final latestEducation = education.isNotEmpty ? education.last : null;
                  return latestEducation != null
                      ? ListTile(
                          title: Text('${latestEducation.degree} at ${latestEducation.institution}'),
                          subtitle: Text('From ${latestEducation.startYear} to ${latestEducation.endYear}'),
                        )
                      : Center(child: Text('No education details available'));
                } else {
                  return Center(child: Text('No education details available'));
                }
              },
            ),
            ListTile(
              title: Text('Experience'),
              // trailing: Icon(Icons.edit),
              onTap: () {
               ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("This feature will shortly be available!")),
                );
              
              },
            ),
            // FutureBuilder<List<ProfessionalDetails>?>(
            //   future: _userExperience,
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return Center(child: CircularProgressIndicator());
            //     } else if (snapshot.hasError) {
            //       return Center(child: Text('Error: ${snapshot.error}'));
            //     } else if (snapshot.hasData) {
            //       final experience = snapshot.data!;
            //       return experience.isNotEmpty
            //           ? ListView.builder(
            //               shrinkWrap: true,
            //               physics: NeverScrollableScrollPhysics(),
            //               itemCount: experience.length,
            //               itemBuilder: (context, index) {
            //                 final exp = experience[index];
            //                 return ListTile(
            //                   title: Text(exp.position),
            //                   subtitle: Text(exp.institution),
            //                 );
            //               },
            //             )
            //           : Center(child: Text('No experience details available'));
            //     } else {
            //       return Center(child: Text('No experience details available'));
            //     }
            //   },
            // ),
            ListTile(
              title: Text('Verification'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("This feature will shortly be available!")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
