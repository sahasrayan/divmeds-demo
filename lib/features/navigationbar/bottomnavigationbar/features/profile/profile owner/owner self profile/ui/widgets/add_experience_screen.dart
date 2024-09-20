import 'package:flutter/material.dart';
import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/features/auth/repositories/user_repo.dart';
import 'package:divmeds/core/api/api.url.dart';
import 'package:divmeds/core/db/local/sharepreferencesmanager.dart';

class AddExperienceScreen extends StatefulWidget {
  final User user;

  const AddExperienceScreen({
    super.key,
    required this.user,
  });

  @override
  _AddExperienceScreenState createState() => _AddExperienceScreenState();
}

class _AddExperienceScreenState extends State<AddExperienceScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _organisationController = TextEditingController();
  final TextEditingController _startYearController = TextEditingController();
  final TextEditingController _endYearController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  bool _isCurrentlyWorking = false;

  void _saveExperience() async {
    if (_formKey.currentState!.validate()) {
      final token = SharedPreferencesManager.getToken();
      if (token != null && token.isNotEmpty) {
        List<ProfessionalDetails> updatedExperience = widget.user.professionalDetails;
        updatedExperience.add(ProfessionalDetails(
          status: 'active',
          institution: _organisationController.text,
          position: _titleController.text,
          startDate: DateTime.tryParse(_startYearController.text) ?? DateTime.now(),
          endDate: _isCurrentlyWorking ? DateTime.now() : DateTime.tryParse(_endYearController.text) ?? DateTime.now(),
          responsibilities: [],
          achievements: [],
          certifications: [],
          publications: [],
          memberships: [],
          skills: [],
        ));
        try {
          await UserRepository(serverUrl: Config.serverUrl).updateProfessionalDetails(updatedExperience, token);
          Navigator.pop(context);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update professional details')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Experience'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _saveExperience,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _organisationController,
                decoration: InputDecoration(labelText: 'Organisation'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an organisation';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _startYearController,
                decoration: InputDecoration(labelText: 'Started in (YYYY-MM-DD)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a start date';
                  } else if (DateTime.tryParse(value) == null) {
                    return 'Please enter a valid date (YYYY-MM-DD)';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isCurrentlyWorking,
                    onChanged: (value) {
                      setState(() {
                        _isCurrentlyWorking = value!;
                      });
                    },
                  ),
                  Text('Currently working here'),
                ],
              ),
              if (!_isCurrentlyWorking)
                TextFormField(
                  controller: _endYearController,
                  decoration: InputDecoration(labelText: 'Worked till (YYYY-MM-DD)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an end date';
                    } else if (DateTime.tryParse(value) == null) {
                      return 'Please enter a valid date (YYYY-MM-DD)';
                    }
                    return null;
                  },
                ),
             
            ],
          ),
        ),
      ),
    );
  }
}
