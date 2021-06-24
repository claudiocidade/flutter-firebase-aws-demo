import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/core/usecases/input.dart';
import 'package:mobile/modules/authentication/presentation/models/phone_info.dart';

class PhoneVerificationRequest extends Input {
  final PhoneInfo phoneInfo;
  final PhoneVerificationCompleted verificationCompleted;
  final PhoneVerificationFailed verificationFailed;
  final PhoneCodeSent codeSent;
  final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout;
  PhoneVerificationRequest({
    required this.phoneInfo,
    required this.verificationCompleted,
    required this.verificationFailed,
    required this.codeSent,
    required this.codeAutoRetrievalTimeout});
}
