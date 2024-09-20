import 'package:bloc/bloc.dart';
import 'package:divmeds/features/auth/twilio/repositories/twilio_repo.dart';
import 'package:divmeds/utils/validators/validators_regex.dart';
import 'package:meta/meta.dart';


part 'auth_enter_mobile_number_event.dart';
part 'auth_enter_mobile_number_state.dart';

class AuthEnterMobileNumberBloc
    extends Bloc<AuthEnterMobileNumberEvent, AuthEnterMobileNumberState> {
  final OtpRepository otpRepository;

  AuthEnterMobileNumberBloc(this.otpRepository) : super(AuthEnterMobileNumberInitial()) {
    on<ContinueButtonPressedEvent>(
      (event, emit) async {
        final phoneNumber = event.phoneNumber;
        if (phoneNumber.isEmpty) {
          return emit(
            AuthEnterMobileNumberFailureState(
                'Please enter your phone number'),
          );
        }
        if (!validateMobileNumber(phoneNumber)) {
          return emit(
            AuthEnterMobileNumberFailureState(
               "Invalid phone number entered!"),
          );
        }

        // Send OTP to the server
        emit(AuthEnterMobileNumberLoadingState());
        final success = await otpRepository.sendOtp(phoneNumber);
        if (success) {
          emit(AuthEnterMobileNumberSuccessState());
        } else {
          emit(AuthEnterMobileNumberFailureState(
            'Failed to send OTP. Please try again later.'
          ));
        }
      },
    );
  }
}
