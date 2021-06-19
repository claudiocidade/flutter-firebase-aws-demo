import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/core/error/failure.dart';
import 'package:mobile/core/usecases/usecase.dart';
import 'package:mobile/modules/authentication/domain/repositories/authentication_repository.dart';
import 'package:mobile/modules/authentication/domain/usecases/phone_verification_input.dart';

class VerifyPhoneNumberUseCase
    implements IUseCase<void, PhoneVerificationInput> {
  final AuthenticationRepository repository;

  VerifyPhoneNumberUseCase(this.repository);

  Future<Either<Failure, void>> execute(PhoneVerificationInput input) async {
    try {
      return Right(await this.repository.verifyPhoneNumber(
          input.phoneNumber,
          input.verificationCompleted,
          input.verificationFailed,
          input.codeSent,
          input.codeAutoRetrievalTimeout));
    } catch (e) {
      return Left(ApplicationFailure(message: e.toString()));
    }
  }
}
