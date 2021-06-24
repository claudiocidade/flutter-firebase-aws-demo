import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/core/error/failure.dart';
import 'package:mobile/core/usecases/usecase.dart';
import 'package:mobile/modules/authentication/domain/repositories/authentication_repository.dart';
import 'package:mobile/modules/authentication/domain/usecases/phone_verification_request.dart';

class VerifyPhoneNumberUseCase
    implements IUseCase<void, PhoneVerificationRequest> {
  final AuthenticationRepository repository;

  VerifyPhoneNumberUseCase(this.repository);

  Future<Either<Failure, void>> execute(
      PhoneVerificationRequest request) async {
    return await this.repository.verifyPhoneNumber(
        request.phoneInfo.toString(),
        request.verificationCompleted,
        request.verificationFailed,
        request.codeSent,
        request.codeAutoRetrievalTimeout);
  }
}
