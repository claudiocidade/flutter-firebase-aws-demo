import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/core/error/failure.dart';

abstract class AuthenticationRemoteDataSource {
  Future<Either<Failure, void>> verifyPhoneNumber(
      String phoneNumber,
      PhoneVerificationCompleted verificationCompleted,
      PhoneVerificationFailed verificationFailed,
      PhoneCodeSent codeSent,
      PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout);
  Future<Either<Failure, User>> confirmVerification(
      String verificationId, String smsCode);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, bool>> checkIsSignedIn();
}
