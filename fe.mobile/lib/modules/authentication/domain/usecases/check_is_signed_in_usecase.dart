import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failure.dart';
import 'package:mobile/core/usecases/usecase.dart';
import 'package:mobile/modules/authentication/domain/repositories/authentication_repository.dart';

class CheckSignedInUseCase implements IUseCase<void, void> {
  final AuthenticationRepository repository;

  CheckSignedInUseCase(this.repository);

  Future<Either<Failure, void>> execute(void _) async {
    return await this.repository.checkIsSignedIn();
  }
}
