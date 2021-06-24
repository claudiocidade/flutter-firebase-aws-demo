import 'package:mobile/core/usecases/input.dart';

class PhoneVerificationConfirmationRequest extends Input {
  final String verificationId;
  final String smsCode;
  PhoneVerificationConfirmationRequest(
      {required this.verificationId, required this.smsCode});
}
