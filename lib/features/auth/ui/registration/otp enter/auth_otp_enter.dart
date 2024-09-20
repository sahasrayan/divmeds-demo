import 'package:divmeds/designs/app_colors.dart';
import 'package:divmeds/features/auth/bloc/registration/bloc/otp%20enter/bloc/auth_otp_enter_bloc.dart';
import 'package:divmeds/features/auth/components/input_button.dart';
import 'package:divmeds/features/auth/components/text_input_field.dart';
import 'package:divmeds/features/auth/ui/registration/birthday%20picker/auth_birthday_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OTPEnter extends StatefulWidget {
  final String phoneNumber;

  const OTPEnter({super.key, required this.phoneNumber});

  @override
  State<OTPEnter> createState() => _OTPEnterState();
}

class _OTPEnterState extends State<OTPEnter> {
  final TextEditingController _otpController = TextEditingController();

  void _otpVerifyToBirthdayPicker() async {
    context.read<AuthOtpEnterBloc>().add(
      ContinueButtonPressedEvent(
        otp: _otpController.text,
        
        phoneNumber: widget.phoneNumber,
      ),
    );
  }

  void _sendCodeAgain() async {
    context.read<AuthOtpEnterBloc>().add(
      SendCodeAgainPressedEvent(
        phoneNumber: widget.phoneNumber,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthOtpEnterBloc, AuthOtpEnterState>(
      listener: (context, state) {
        if (state is AuthOtpEnterOTPVerificationFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
        if (state is AuthOtpEnterOTPVerificationSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.otpVerifiedMessage),
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const BirthdayPicker();
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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: Center(
            child: Column(
              children: [
                const Text(
                  "Verify your account",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextInputField(
                  hintText: "Enter code",
                  obscureText: false,
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputButton(
                  onPressed: () {
                    _otpVerifyToBirthdayPicker();
                    print("OTP Submitted!");
                  },
                  buttonName: "Continue",
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _sendCodeAgain();
                        print("Send Code again pressed!");
                      },
                      child: const Text(
                        "Send code again",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.divMedsColorBlue3,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        print("Wrong number pressed!");
                      },
                      child: const Text(
                        "Wrong number?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.divMedsColorBlue3,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
