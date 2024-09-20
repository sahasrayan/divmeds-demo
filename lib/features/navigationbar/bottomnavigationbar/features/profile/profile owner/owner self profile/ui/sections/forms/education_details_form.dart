import 'package:divmeds/features/auth/components/text_input_field.dart';
import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/features/auth/repositories/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:divmeds/designs/app_colors.dart';

final GlobalKey<FormState> _educationalDetailsFormKey = GlobalKey<FormState>();

class EditProfileEducationalDetailsSection extends StatefulWidget {
  final String token;
  final UserRepository userRepository;

  const EditProfileEducationalDetailsSection({
    required this.token,
    required this.userRepository,
    super.key,
  });

  @override
  State<EditProfileEducationalDetailsSection> createState() =>
      _EditProfileEducationalDetailsSectionState();
}

class _EditProfileEducationalDetailsSectionState
    extends State<EditProfileEducationalDetailsSection> {
  final TextEditingController _institutionNameController =
      TextEditingController();
  final TextEditingController _startYearController = TextEditingController();
  final TextEditingController _endYearController = TextEditingController();

  String _selectedDegree = "Select";
  String _selectedCurrentYear = "Select";
  bool _isEditingDegree = false;
  bool _isEditingInstitution = false;
  bool _isEditingStartYear = false;
  bool _isEditingEndYear = false;
  bool _isEditingCurrentYear = false;
  bool _isUpdatingEducation = false;
  bool _isEditMode = false;

  late Future<List<Education>?> _educationDetails;

  @override
  void initState() {
    super.initState();
    _educationDetails = _loadEducationDetails();
  }

  Future<List<Education>?> _loadEducationDetails() async {
    return await widget.userRepository.getUserEducation(widget.token);
  }

  Future<void> _updateEducation() async {
    if (_educationalDetailsFormKey.currentState!.validate()) {
      final education = Education(
        degree: _selectedDegree,
        institution: _institutionNameController.text,
        startYear: _startYearController.text,
        endYear: _endYearController.text,
  
      );

      setState(() {
        _isUpdatingEducation = true;
      });

      try {
        await widget.userRepository.updateEducation([education], widget.token);
        setState(() {
          _isUpdatingEducation = false;
          _isEditMode = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Educational details updated successfully!')),
        );
      } catch (e) {
        setState(() {
          _isUpdatingEducation = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update educational details')),
        );
      }
    }
  }

  void _toggleEditMode() {
    setState(() {
      _isEditMode = !_isEditMode;
    });
  }

  void _cancelEdit() {
    setState(() {
      _isEditMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Education>?>(
      future: _educationDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading educational details'));
        } else {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.isNotEmpty) {
            Education education = snapshot.data!.first;
            _institutionNameController.text = education.institution;
            _startYearController.text = education.startYear.toString();
            _endYearController.text = education.endYear.toString();
            _selectedDegree = education.degree;
        
          }
          return Form(
            key: _educationalDetailsFormKey,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                  ),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(4, 20, 4, 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Educational Details",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(_isEditMode ? Icons.cancel : Icons.edit),
                        onPressed: _toggleEditMode,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  buildDropdownRow(
                    "Degree",
                    _selectedDegree,
                    _isEditMode && _isEditingDegree,
                    (newValue) {
                      setState(() {
                        _selectedDegree = newValue!;
                        _isEditingDegree = !_isEditingDegree;
                      });
                    },
                    () {
                      setState(() {
                        _isEditingDegree = !_isEditingDegree;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  buildDetailRow(
                    "Institution Name",
                    _institutionNameController,
                    _isEditMode && _isEditingInstitution,
                    () {
                      setState(() {
                        _isEditingInstitution = !_isEditingInstitution;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  buildDetailRow(
                    "Start Year",
                    _startYearController,
                    _isEditMode && _isEditingStartYear,
                    () {
                      setState(() {
                        _isEditingStartYear = !_isEditingStartYear;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  buildDetailRow(
                    "End Year",
                    _endYearController,
                    _isEditMode && _isEditingEndYear,
                    () {
                      setState(() {
                        _isEditingEndYear = !_isEditingEndYear;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  buildDropdownRow(
                    "Current Year",
                    _selectedCurrentYear,
                    _isEditMode && _isEditingCurrentYear,
                    (newValue) {
                      setState(() {
                        _selectedCurrentYear = newValue!;
                        _isEditingCurrentYear = !_isEditingCurrentYear;
                      });
                    },
                    () {
                      setState(() {
                        _isEditingCurrentYear = !_isEditingCurrentYear;
                      });
                    },
                    dropdownItems: [
                      DropdownMenuItem(value: "1st Year", child: Text("1st")),
                      DropdownMenuItem(value: "2nd Year", child: Text("2nd")),
                      DropdownMenuItem(value: "3rd Year", child: Text("3rd")),
                      DropdownMenuItem(value: "4th Year", child: Text("4th")),
                      DropdownMenuItem(
                          value: "Internship", child: Text("Internship")),
                      DropdownMenuItem(
                          value: "HousestaffShip",
                          child: Text("HousestaffShip")),
                      DropdownMenuItem(value: "Select", child: Text("Select")),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (_isEditMode)
                    Row(
                      children: [
                        Expanded(
                          child: InputButton(
                            onPressed: _isUpdatingEducation
                                ? null
                                : _updateEducation,
                            buttonName:
                                _isUpdatingEducation ? 'Updating...' : 'Submit',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: InputButton(
                            onPressed: _cancelEdit,
                            buttonName: 'Cancel',
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget buildDropdownRow(
    String label,
    String selectedValue,
    bool isEditing,
    ValueChanged<String?> onChanged,
    VoidCallback onEdit, {
    List<DropdownMenuItem<String>>? dropdownItems,
  }) {
    return Row(
      children: [
        Expanded(
          child: isEditing
              ? DropdownButtonFormField<String>(
                  value: selectedValue,
                  items: dropdownItems ??
                      [
                        DropdownMenuItem(value: "MBBS", child: Text("MBBS")),
                        DropdownMenuItem(
                            value: "BPharm", child: Text("BPharm")),
                        DropdownMenuItem(value: "BDS", child: Text("BDS")),
                        DropdownMenuItem(value: "BPT", child: Text("BPT")),
                        DropdownMenuItem(value: "BSC Nurshing", child: Text("BPT")),
                        DropdownMenuItem(value: "Other", child: Text("Other")),
                        DropdownMenuItem(value: "Select", child: Text("Select")),
                      ],
                  onChanged: onChanged,
                  decoration: InputDecoration(labelText: label),
                )
              : Text(selectedValue),
        ),
        if (_isEditMode)
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit),
            onPressed: onEdit,
          ),
      ],
    );
  }

  Widget buildDetailRow(
    String label,
    TextEditingController controller,
    bool isEditing,
    VoidCallback onEdit,
  ) {
    return Row(
      children: [
        Expanded(
          child: isEditing
              ? TextInputField(
                  hintText: label,
                  obscureText: false,
                  controller: controller,
                )
              : Text(controller.text.isEmpty ? label : controller.text),
        ),
        if (_isEditMode)
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit),
            onPressed: onEdit,
          ),
      ],
    );
  }
}

class InputButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonName;
  const InputButton({
    super.key,
    required this.onPressed,
    required this.buttonName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: AppColors.divMedsColorBlueScaffoldAccent,
        ),
        child: Center(
          child: Text(
            buttonName,
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.divMedsColorBlueScaffoldBackground,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
