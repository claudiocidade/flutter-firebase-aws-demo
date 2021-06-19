import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/core/error/failure.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, void>> verifyPhoneNumber(
      String phoneNumber,
      PhoneVerificationCompleted verificationCompleted,
      PhoneVerificationFailed verificationFailed,
      PhoneCodeSent codeSent,
      PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout);
  Future<Either<Failure, UserCredential>> confirmVerification(
      String verificationId, String smsCode);
  Future<Either<Failure, void>> signOut();
}
