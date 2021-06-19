import 'package:mobile/core/usecases/input.dart';

class PhoneVerificationConfirmationInput extends Input {
  final String verificationId;
  final String smsCode;
  PhoneVerificationConfirmationInput(
      {required this.verificationId, required this.smsCode});
}
