

// Regular expression for username validation

// final RegExp usernameRegex = RegExp(r'^(?!^[0-9])[a-zA-Z0-9_]{3,20}$');
final RegExp usernameRegex = RegExp(r'^(?!^[0-9])[a-z0-9_]{3,20}$');


// Function to validate a username
bool validateUsername(String username) {
  return usernameRegex.hasMatch(username);
}

// Regular expression for mobile number validation
final RegExp mobileRegex = RegExp(r'^\d{10}$');

// Function to validate a mobile number
bool validateMobileNumber(String mobileNumber) {
  return mobileRegex.hasMatch(mobileNumber);
}
// Regular expression for email validation
final RegExp emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

// Function to validate an email address
bool validateEmail(String email) {
  return emailRegex.hasMatch(email);
}

// Regular expression for name validation
final RegExp nameRegex = RegExp(r'^[a-zA-Z]+(?: [a-zA-Z]+)*$');

// Function to validate a name
bool validateName(String name) {
  return nameRegex.hasMatch(name);
}

// Regular expression for password validation
final RegExp passwordRegex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,12}$');

// Function to validate a password
bool validatePassword(String password) {
  return passwordRegex.hasMatch(password);
}

// Regular expression for four digits numeric otp

final RegExp otpFourNumericRegex = RegExp(r'^\d{4}$');

// Function to validate a four digits numeric otp

bool validateFourDigitNumericOTP(String otp) {

  return otpFourNumericRegex.hasMatch(otp);
}
