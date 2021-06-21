import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/core/error/failure.dart';
import 'package:firebase_auth_platform_interface/src/types.dart';
import 'package:mobile/modules/authentication/domain/repositories/authentication_repository.dart';
import 'package:mobile/modules/authentication/data/datasources/authentication_remote_datasource.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource remoteDataSource;

  AuthenticationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> verifyPhoneNumber(
      String phoneNumber,
      PhoneVerificationCompleted verificationCompleted,
      PhoneVerificationFailed verificationFailed,
      PhoneCodeSent codeSent,
      PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout) async {
    return await this.remoteDataSource.verifyPhoneNumber(
        phoneNumber,
        verificationCompleted,
        verificationFailed,
        codeSent,
        autoRetrievalTimeout);
  }

  @override
  Future<Either<Failure, UserCredential>> confirmVerification(
      String verificationId, String smsCode) async {
    return await this
        .remoteDataSource
        .confirmVerification(verificationId, smsCode);
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    return await this.remoteDataSource.signOut();
  }

  @override
  Future<Either<Failure, bool>> checkIsSignedIn() async {
    return await this.remoteDataSource.checkIsSignedIn();
  }
}
