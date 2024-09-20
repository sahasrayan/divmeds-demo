import 'package:divmeds/core/api/api.url.dart';
import 'package:flutter/material.dart';
import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/features/auth/repositories/user_repo.dart';
import 'package:divmeds/core/db/local/sharepreferencesmanager.dart';
import 'dart:developer';

class AddEducationScreen extends StatefulWidget {
  final User user;

  const AddEducationScreen({
    super.key,
    required this.user,
  });

  @override
  _AddEducationScreenState createState() => _AddEducationScreenState();
}

class _AddEducationScreenState extends State<AddEducationScreen> {
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _startYearController = TextEditingController();
  final TextEditingController _endYearController = TextEditingController();
  bool _currentlyStudying = false;
  final UserRepository _userRepository = UserRepository(serverUrl: Config.serverUrl);

  void _saveEducation() async {
    final token = SharedPreferencesManager.getToken();
    if (token != null && token.isNotEmpty) {
      List<Education> updatedEducation = List.from(widget.user.education);

      // Validate the input fields before adding to the list
      if (_degreeController.text.isNotEmpty &&
          _institutionController.text.isNotEmpty &&
          _startYearController.text.isNotEmpty &&
          (_currentlyStudying || _endYearController.text.isNotEmpty)) {
        
        updatedEducation.add(Education(
          degree: _degreeController.text,
          institution: _institutionController.text,
          startYear: _startYearController.text,
          endYear: _currentlyStudying ? 'Present' : _endYearController.text,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill all the fields')),
        );
        return;
      }

      // Filter out invalid entries from the updated education list
      updatedEducation = updatedEducation.where((edu) => 
        edu.degree.isNotEmpty && edu.institution.isNotEmpty && edu.startYear.isNotEmpty && 
        (edu.endYear.isNotEmpty || edu.endYear == 'Present')).toList();

      try {
        await _userRepository.updateEducation(updatedEducation, token);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Education details updated successfully')),
        );
        Navigator.pop(context);
      } catch (e) {
        log('Failed to update education details: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update education details')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not authenticated')),
      );
    }
  }

  @override
  void dispose() {
    _degreeController.dispose();
    _institutionController.dispose();
    _startYearController.dispose();
    _endYearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Education'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _saveEducation,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _degreeController,
              decoration: InputDecoration(labelText: 'Degree'),
            ),
            TextField(
              controller: _institutionController,
              decoration: InputDecoration(labelText: 'School/University/College'),
            ),
            TextField(
              controller: _startYearController,
              decoration: InputDecoration(labelText: 'Started in'),
            ),
            Row(
              children: [
                Checkbox(
                  value: _currentlyStudying,
                  onChanged: (value) {
                    setState(() {
                      _currentlyStudying = value ?? false;
                    });
                  },
                ),
                Text('Currently studying here'),
              ],
            ),
            if (!_currentlyStudying)
              TextField(
                controller: _endYearController,
                decoration: InputDecoration(labelText: 'Studied till'),
              ),
          ],
        ),
      ),
    );
  }
}
