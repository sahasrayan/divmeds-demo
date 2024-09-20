
import 'package:bloc/bloc.dart';
import 'package:divmeds/features/auth/twilio/repositories/twilio_repo.dart';
import 'package:divmeds/utils/validators/validators_regex.dart';
import 'package:meta/meta.dart';

part 'auth_otp_enter_event.dart';
part 'auth_otp_enter_state.dart';

class AuthOtpEnterBloc extends Bloc<AuthOtpEnterEvent, AuthOtpEnterState> {
  final OtpRepository otpRepository;
  final String phoneNumber;

  AuthOtpEnterBloc({required this.otpRepository, required this.phoneNumber})
      : super(AuthOtpEnterInitial()) {
    on<ContinueButtonPressedEvent>((event, emit) async {
      try {
        final otp = event.otp;
        if (otp.isEmpty) {
          return emit(AuthOtpEnterOTPVerificationFailedState(
            "Please enter the four-digit numeric OTP sent to you.",
          ));
        }
        if (!validateFourDigitNumericOTP(otp)) {
          return emit(AuthOtpEnterOTPVerificationFailedState(
            "Please enter the four-digit numeric OTP sent to you.",
          ));
        }

        emit(AuthOtpEnterVerifyingOTPLoadingState());

        final isVerified = await otpRepository.verifyOtp(phoneNumber, otp);
        if (isVerified) {
          emit(AuthOtpEnterOTPVerificationSuccessState(
            "OTP verified successfully.",
          ));
        } else {
          emit(AuthOtpEnterOTPVerificationFailedState(
            "Invalid OTP. Please try again.",
          ));
        }
      } catch (error) {
        emit(AuthOtpEnterOTPVerificationFailedState(error.toString()));
      }
    });

    on<SendCodeAgainPressedEvent>((event, emit) async {
      try {
        emit(AuthOtpEnterVerifyingOTPLoadingState());
        final isSent = await otpRepository.resendOtp(phoneNumber);
        if (isSent) {
          emit(AuthOtpEnterInitial());
        } else {
          emit(AuthOtpEnterOTPVerificationFailedState(
            "Failed to resend OTP. Please try again.",
          ));
        }
      } catch (error) {
        emit(AuthOtpEnterOTPVerificationFailedState(error.toString()));
      }
    });
  }
}
