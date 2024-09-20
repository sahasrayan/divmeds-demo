import 'package:flutter/material.dart';
import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:dio/dio.dart';
import 'package:divmeds/core/api/api.url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer';
import 'dart:io';

class EditProfileScreen extends StatefulWidget {
  final User user;

  const EditProfileScreen({
    super.key,
    required this.user,
  });

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController aboutController;
  File? _image;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.user.firstName);
    lastNameController = TextEditingController(text: widget.user.lastName);
    aboutController = TextEditingController(text: widget.user.aboutSection);
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final token = await _getToken();
    if (token != null) {
      try {
        final response = await Dio().get(
          '${Config.serverUrl}/me/about',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          ),
        );

        if (response.statusCode == 200) {
          setState(() {
            aboutController.text = response.data['aboutSection'] ?? '';
          });
        } else {
          log('Failed to load about section data');
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateProfilePicture(String token) async {
    if (_image == null) return;
    try {
      String fileName = _image!.path.split('/').last;
      FormData formData = FormData.fromMap({
        "profilePicture": await MultipartFile.fromFile(_image!.path, filename: fileName),
      });

      await updateProfilePicture(formData, token);
      _showSnackBar(context, 'Profile picture updated successfully');
    } catch (e) {
      log(e.toString());
      _showSnackBar(context, 'Failed to update profile picture');
    }
  }

  Future<void> _removeProfilePicture(String token) async {
    try {
      await removeProfilePicture(token);
      setState(() {
        _image = null;
      });
      _showSnackBar(context, 'Profile picture removed successfully');
    } catch (e) {
      log(e.toString());
      _showSnackBar(context, 'Failed to remove profile picture');
    }
  }

  Future<void> updateAboutSection(String aboutSection, String token) async {
    try {
      final response = await Dio().put(
        '${Config.serverUrl}/me/about',
        data: {'aboutSection': aboutSection},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('About section updated successfully');
        _showSnackBar(context, 'About section updated successfully');
      } else {
        throw Exception('Failed to update about section');
      }
    } catch (e) {
      log(e.toString());
      _showSnackBar(context, 'Failed to update about section');
      throw Exception('Failed to update about section');
    }
  }

  Future<void> updateProfileName(Map<String, dynamic> updates, String token) async {
    try {
      final response = await Dio().put(
        '${Config.serverUrl}/update/name',
        data: updates,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('Profile name updated successfully');
        _showSnackBar(context, 'Profile name updated successfully');
      } else {
        throw Exception('Failed to update profile name');
      }
    } catch (e) {
      log(e.toString());
      _showSnackBar(context, 'Failed to update profile name');
      throw Exception('Failed to update profile name');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              final updates = {
                'firstName': firstNameController.text,
                'lastName': lastNameController.text,
              };
              final aboutSection = aboutController.text;
              final token = await _getToken();

              if (token != null) {
                await updateProfileName(updates, token);
                await updateAboutSection(aboutSection, token);
                await _updateProfilePicture(token);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _image == null ? NetworkImage(widget.user.profilePicture) : FileImage(_image!) as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: _pickImage,
                        ),
                      ),
                    ),
                    if (_image != null) // Show remove icon only if an image is selected
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              final token = await _getToken();
                              if (token != null) {
                                await _removeProfilePicture(token);
                              }
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Basic Info',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              SizedBox(height: 16),
              Text(
                'About',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                controller: aboutController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'About Yourself',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Update user profile picture
  Future<void> updateProfilePicture(FormData formData, String token) async {
    try {
      final response = await Dio().put(
        '${Config.serverUrl}/update-profile-picture',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('Profile picture updated successfully');
      } else {
        throw Exception('Failed to update profile picture');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to update profile picture');
    }
  }

  // Remove user profile picture
  Future<void> removeProfilePicture(String token) async {
    try {
      final response = await Dio().delete(
        '${Config.serverUrl}/remove-profile-picture',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log('Profile picture removed successfully');
      } else {
        throw Exception('Failed to remove profile picture');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to remove profile picture');
    }
  }
}
