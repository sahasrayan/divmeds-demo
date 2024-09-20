part of 'auth_forgot_password_bloc.dart';

@immutable
sealed class AuthForgotPasswordState {}

final class AuthForgotPasswordInitial extends AuthForgotPasswordState {}
// when the user presses the 'Send code' button existing in the 
// 'Find your account' screen , an otp request is
// going to be sent to the server and an otp
// will be received by the user

// Listner function:
final class AuthForgotPasswordSendCodeFailureState extends AuthForgotPasswordState {
// SendCodeFailureState will be returned in cases of while
// checking the entered phone number's 
// validity [isempty,regex & if the mobile number is registered or not.]
  
}
final class AuthForgotPasswordSendCodeSuccesState extends AuthForgotPasswordState {

// This state will be returned in case of the 
// otp request has been sent successfully
// The UI will be updated accordingly -> Executuion of builder function
}
// When the SendCodeSuccesState has been returned then the app ui 
// is gonna build the 'Confirm your code' screen.
// Confirm your code has the 'Continue' button for checking
// the user entered otp is correct or not and if it is correct then it is 
// gonna send the user to the next screen 'Create a new password' screen
// & if the user entered code is incorrect then the listner function
// will show a Scaffold Messenger saying the user entered code is incorrect.



