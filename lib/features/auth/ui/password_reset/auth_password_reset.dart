import 'package:divmeds/designs/app_colors.dart';
import 'package:divmeds/features/auth/components/input_button.dart';
import 'package:divmeds/features/auth/components/text_input_field.dart';
import 'package:flutter/material.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();
  bool _isPasswordSentToServerSuccessfully = false;
// Implement submit button clicked event
  void _submitButtonClicked(){
    setState(() {
      _isPasswordSentToServerSuccessfully = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        appBar: AppBar( backgroundColor: Colors.transparent,),
        body: Center(
          child: Column(
            children: [
              const Text(
                "Create a new password",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextInputField(
                  hintText: "Enter your new password",
                  obscureText: true,
                  controller: _newPasswordController),
              const SizedBox(height: 30),
              TextInputField(
                  hintText: "Confirm your new password",
                  obscureText: false,
                  controller: _confirmNewPasswordController),
              const SizedBox(
                height: 40,
              ),
              InputButton(
                onPressed: () {
                  setState(
                    () {
                      // new password created submit button logic implementation
                      _submitButtonClicked();
                      if (_isPasswordSentToServerSuccessfully){
                        Navigator.of(context).popUntil((route) => route.isFirst);
                        
                      }
                      
                     
          
                      print("Password change submit button clicked!");
                    },
                  );
                },
                buttonName: "Submit",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// void _submitButtonClicked() {
//     _newPasswordController.text != _confirmNewPasswordController.text
//         ? ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               backgroundColor: Colors.grey[200],
//               content: const Text(
//                 'Passwords do not match',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: AppColors.divMedsColorBlue3,
//                   fontSize: 15,
//                 ),
//               ),
//             ),
//           )
//         :
//         // Implement await async logic for sending the new passsword to the server.
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               backgroundColor: Colors.white,
//               content: Text(
//                 'Password changed successfully',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: AppColors.divMedsColorBlue3,
//                   fontSize: 15,
//                 ),
//               ),
//             ),
            
//           );

//              // password changed logic
 
  
//   }