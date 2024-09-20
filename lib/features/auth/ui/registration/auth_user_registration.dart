import 'package:divmeds/features/auth/ui/registration/terms%20and%20conditions/auth_terms_and_conditions.dart';
import 'package:flutter/material.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({super.key});

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  @override
  Widget build(BuildContext context) {
    // UserRegistration -> TermsAndConditions -> EnterMobileNumber -> SubmitOTP -> BirthdayPicker -> UserRegistrationForm (userid - fullname - gender - password)
    return const TermsAndConditions();
  }
}
