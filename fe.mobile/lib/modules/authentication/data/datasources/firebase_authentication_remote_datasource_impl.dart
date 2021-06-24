import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/core/error/failure.dart';
import 'package:mobile/modules/authentication/data/datasources/authentication_remote_datasource.dart';
import 'package:mobile/modules/authentication/errorhandling/authentication_failure.dart';

class FirebaseAuthRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  Future<Either<Failure, void>> verifyPhoneNumber(
      String phoneNumber,
      PhoneVerificationCompleted verificationCompleted,
      PhoneVerificationFailed verificationFailed,
      PhoneCodeSent codeSent,
      PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout) async {
    if (FirebaseAuth.instance.currentUser != null) {}
    return Right(await FirebaseAuth
      .instance
      .verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: Duration(seconds: 120), // TODO: Refactor
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout));
  }

  Future<Either<Failure, User>> confirmVerification(
      String verificationId, String smsCode) async {
    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      final firebaseUser = await await FirebaseAuth.instance
          .signInWithCredential(credential);
      return Right(firebaseUser.user);
    } on FirebaseAuthException catch (e) {
      return Left(
          UnhandledAuthenticationFailure(exception: e));
    }
  }

  Future<Either<Failure, void>> signOut() async {
    return Right(await FirebaseAuth.instance.signOut());
  }

  @override
  Future<Either<Failure, bool>> checkIsSignedIn() async {
    try {
      return FirebaseAuth.instance.currentUser != null
          ? Right(true)
          : Right(false);
    } on FirebaseAuthException catch (e) {
      return Left(
          UnhandledAuthenticationFailure(exception: e));
    }
  }
}
