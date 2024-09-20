import 'package:divmeds/core/db/local/sharepreferencesmanager.dart';
import 'package:divmeds/designs/app_colors.dart';
import 'package:divmeds/features/auth/auth_global_variables.dart';
import 'package:divmeds/features/auth/bloc/registration/bloc/enter%20mobile%20number/bloc/auth_enter_mobile_number_bloc.dart';
import 'package:divmeds/features/auth/components/input_button.dart';
import 'package:divmeds/features/auth/components/text_input_field.dart';
import 'package:divmeds/features/auth/ui/registration/otp%20enter/auth_otp_enter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnterMobileNumber extends StatefulWidget {
  const EnterMobileNumber({super.key});

  @override
  State<EnterMobileNumber> createState() => _EnterMobileNumberState();
}

class _EnterMobileNumberState extends State<EnterMobileNumber> {
  final TextEditingController _mobileController = TextEditingController();

void _otpEnterPage() {
    String phoneNumber = _mobileController.text.trim();
    context.read<AuthEnterMobileNumberBloc>().add(
          ContinueButtonPressedEvent(
            phoneNumber: phoneNumber,
          ),
        );
    authMobileNumber = phoneNumber;
    SharedPreferencesManager.savePhoneNumber(phoneNumber);
  }
  @override
  void dispose() {
    super.dispose();
    _mobileController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthEnterMobileNumberBloc, AuthEnterMobileNumberState>(
      listener: (context, state) {
        if (state is AuthEnterMobileNumberFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
        if (state is AuthEnterMobileNumberSuccessState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return OTPEnter(phoneNumber: _mobileController.text.trim());
              },
            ),
          );
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.divMedsColorWhite,
              AppColors.divMedsColorWhite,
              AppColors.divMedsColorWhite,
              AppColors.divMedsColorBlue4,
            ],
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              children: [
                const Text(
                  "Enter your mobile number",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextInputField(
                  hintText: "Mobile Number",
                  obscureText: false,
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputButton(
                  onPressed: () {
                    _otpEnterPage();
                  },
                  buttonName: "Continue",
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
