import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/core/usecases/input.dart';

class PhoneVerificationRequest extends Input {
  final String phoneNumber;
  final PhoneVerificationCompleted verificationCompleted;
  final PhoneVerificationFailed verificationFailed;
  final PhoneCodeSent codeSent;
  final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout;
  PhoneVerificationRequest(
      {required this.phoneNumber,
      required this.verificationCompleted,
      required this.verificationFailed,
      required this.codeSent,
      required this.codeAutoRetrievalTimeout});
}
