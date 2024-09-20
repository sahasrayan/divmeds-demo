import 'package:divmeds/core/db/local/sharepreferencesmanager.dart';
import 'package:divmeds/designs/app_colors.dart';
import 'package:divmeds/features/auth/auth_global_variables.dart';
import 'package:divmeds/features/auth/components/input_button.dart';
import 'package:divmeds/features/auth/components/text_input_field.dart';
import 'package:divmeds/features/auth/ui/registration/user%20registration%20form/auth_user_registration_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BirthdayPicker extends StatefulWidget {
  const BirthdayPicker({super.key});

  @override
  State<BirthdayPicker> createState() => _BirthdayPickerState();
}

class _BirthdayPickerState extends State<BirthdayPicker> {
  final TextEditingController _dateOfBirthController = TextEditingController(text: authDOB);
  int _age = 0;
  // @override
  // void initState() {
  //   super.initState();
  //   _dateOfBirthController.text = "";
  // }

  _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
     initialDatePickerMode: DatePickerMode.year,
     fieldHintText: "DD/MM/YYYY",
     errorInvalidText: "You must be atleast 16 years old to register!",
     errorFormatText: "Please enter in the given format!",
      firstDate: DateTime(1960),
      // Maintaining the minimum age of 16 Years
      lastDate: DateTime.now().subtract(
        const Duration(
          days: 16 * 365,
          hours: 96,
        ),
      ),
    );

    setState(
      () {
        _dateOfBirthController.text =
            DateFormat("dd-MM-yyyy").format(pickedDate!).toString();
            int selectedYear = pickedDate.year;
            int currentYear = DateTime.now().year ;
            int selectedMonth = pickedDate.month ;
            int currentMonth = DateTime.now().month;
           
            int totalMonths = (currentYear - selectedYear) * 12 +
                (currentMonth- selectedMonth) ;
           int floorAge = (totalMonths/12).floor();
            _age = floorAge;
         
         authDOB =  _dateOfBirthController.text;
          // Save DOB to shared preferences
        SharedPreferencesManager.saveDOB(pickedDate);
      
      },
    );
  }
  void _userRegForm() {
  if (_dateOfBirthController.text.isNotEmpty) {
    // If the date of birth is provided, navigate to the next page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const UserRegistrationForm();
        },
      ),
    );
  } else {
    // If the date of birth is not provided, show a snackbar with an error message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.white,
        content: Text("Enter your birth date to continue further", style: TextStyle(
           color: AppColors.divMedsColorBlue3,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
        ),),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
  // void _userRegForm(){
    
     
  //   // setState(() {
  //   //    Navigator.push(
  //   //   context,
  //   //   MaterialPageRoute(
  //   //     builder: (context) {
  //   //       return const UserRegistrationForm();
  //   //     },
  //   //   ),
  //   // );
  //   // }
  //   // );
  
  // }

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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Column(
            children: [
              const Text(
                "Enter your date of birth",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextInputField(
                onTap: () {
                  _showDatePicker();
                },
                hintText: "DD/MM/YYYY",
                showCursor: false,
                obscureText: false,
                controller: _dateOfBirthController,
                prefixIconWidget: const Icon(Icons.calendar_month_outlined),
              ),
              const SizedBox(
                height: 20,
              ),
             
              _age != 0
              // Using sizedBox as cointainer to implement the ternary opeartors cleanly.
                  ? SizedBox(
                    height: 100,
                    width: 400,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "I am ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "$_age ",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text(
                            "years old.",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),

              const SizedBox(
                height: 40,
              ),
              InputButton(
                buttonName: "Continue",
                onPressed: () {
                  _userRegForm();
                }
                         
                
              ),
            ],
          ),
        ),
      ),

      // child: CupertinoPageScaffold(
      //   backgroundColor: Colors.transparent,
      //   navigationBar: const CupertinoNavigationBar(
      //     backgroundColor: Colors.transparent,
      //     border: Border(
      //       bottom: BorderSide.none,
      //     ),
      //   ),
      //   child: Center(
      //     child: Column(
      //       children: [
      //         const SizedBox(
      //           height: 110,
      //         ),
      //         const Text(
      //           "Enter your birthday",
      //           style: TextStyle(
      //             color: Colors.black,
      //             fontSize: 20,
      //             fontWeight: FontWeight.w600,
      //           ),
      //         ),
      //         const SizedBox(height: 200,),
      //         Container(

      //           child: CupertinoButton(
      //             child: const Text(
      //               "What is your age?",
      //               style: TextStyle(
      //                 color: Colors.black,
      //                 fontSize: 20,
      //                 fontWeight: FontWeight.w600,
      //               ),
      //             ),
      //             onPressed: () {
      //               showCupertinoModalPopup(
      //                   context: context,
      //                   builder: (BuildContext context) {
      //                     return SizedBox(
      //                       height: 200,
      //                       child: CupertinoDatePicker(
      //                         mode: CupertinoDatePickerMode.date,

      //                          maximumDate: DateTime.now(),
      //                         backgroundColor: Colors.white,
      //                         initialDateTime: initialDateTime,
      //                         onDateTimeChanged: (DateTime newTime) {
      //                           setState(() {
      //                             initialDateTime = newTime;
      //                           });
      //                         },
      //                       ),
      //                     );
      //                   });
      //             },
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
