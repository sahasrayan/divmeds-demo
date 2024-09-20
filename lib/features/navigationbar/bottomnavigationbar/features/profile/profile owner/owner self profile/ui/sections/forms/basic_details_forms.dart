import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:divmeds/features/auth/models/user.model.dart';
import 'package:divmeds/features/auth/repositories/user_repo.dart';

final GlobalKey<FormState> _basicDetailsFormKey = GlobalKey<FormState>();

class EditProfileBasicDetailsSection extends StatefulWidget {
  final String token;
  final UserRepository userRepository;

  const EditProfileBasicDetailsSection({
    required this.token,
    required this.userRepository,
    super.key,
  });

  @override
  State<EditProfileBasicDetailsSection> createState() =>
      _EditProfileBasicDetailsSectionState();
}

class _EditProfileBasicDetailsSectionState
    extends State<EditProfileBasicDetailsSection> {
  late Future<User?> _userProfile;

  @override
  void initState() {
    super.initState();
    _userProfile = _loadUserProfile();
  }

  Future<User?> _loadUserProfile() async {
    return await widget.userRepository.getLoggedInUserProfile(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _userProfile,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading user data'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('No user data available'));
        } else {
          User user = snapshot.data!;
          return Form(
            key: _basicDetailsFormKey,
            child: Container(
              padding: const EdgeInsets.fromLTRB(4, 20, 4, 8),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Basic Details",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  buildDetailRow("First Name", user.firstName),
                  const SizedBox(height: 12),
                  buildDetailRow("Last Name", user.lastName),
                  const SizedBox(height: 12),
                  buildDetailRow("User ID", user.userId),
                  const SizedBox(height: 12),
                  buildDetailRow("Mobile Number", user.phone),
                  const SizedBox(height: 12),
                  buildDetailRow("Date of Birth",
                      DateFormat('dd-MM-yyyy').format(user.dob as DateTime)),
                  const SizedBox(height: 12),
                  buildGenderRow("Gender", user.gender),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            value.isEmpty ? label : value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget buildGenderRow(String label, String selectedValue) {
    return Row(
      children: [
        Expanded(
          child: Text(
            selectedValue.isEmpty ? label : selectedValue,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
