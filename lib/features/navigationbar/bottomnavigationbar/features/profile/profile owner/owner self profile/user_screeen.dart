import 'package:divmeds/core/api/api.url.dart';
import 'package:divmeds/features/auth/repositories/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/core/db/local/sharepreferencesmanager.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late UserRepository _userRepository;
  late String _token;

  @override
  void initState() {
    super.initState();
    _userRepository = UserRepository(serverUrl: Config.serverUrl);
    _token = Config.token;
  }

  Future<User?> _fetchUserProfile() async {
    return await _userRepository.getLoggedInUserProfile(_token);
  }

  Future<List<Education>?> _fetchUserEducation() async {
    return await _userRepository.getUserEducation(_token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: FutureBuilder<User?>(
        future: _fetchUserProfile(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (userSnapshot.hasError) {
            return Center(child: Text('Error: ${userSnapshot.error}'));
          }

          if (!userSnapshot.hasData) {
            return Center(child: Text('No user data found'));
          }

          final user = userSnapshot.data!;
          
          return ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              // User Profile Details
              CircleAvatar(
                radius: 50,
                backgroundImage: user.profilePicture.isNotEmpty
                    ? NetworkImage(user.profilePicture)
                    : AssetImage('assets/default_profile_picture.png') as ImageProvider,
              ),
              SizedBox(height: 16.0),
              Text(
                '${user.firstName} ${user.lastName}',
                
              ),
              SizedBox(height: 8.0),
              Text(
                user.email,
               
              ),
              SizedBox(height: 16.0),

              // User Education Details
              FutureBuilder<List<Education>?>(
                future: _fetchUserEducation(),
                builder: (context, educationSnapshot) {
                  if (educationSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (educationSnapshot.hasError) {
                    return Center(child: Text('Error: ${educationSnapshot.error}'));
                  }

                  if (!educationSnapshot.hasData || educationSnapshot.data!.isEmpty) {
                    return Center(child: Text('No education details found'));
                  }

                  final educationList = educationSnapshot.data!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Education Details',
                       
                      ),
                      SizedBox(height: 8.0),
                      ...educationList.map((edu) {
                        return ListTile(
                          title: Text(edu.degree),
                          subtitle: Text('${edu.institution} (${edu.startYear} - ${edu.endYear})'),
                        );
                      }).toList(),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
