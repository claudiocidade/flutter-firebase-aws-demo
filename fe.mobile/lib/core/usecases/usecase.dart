import 'package:dartz/dartz.dart';
import 'package:mobile/core/error/failure.dart';

abstract class IUseCase<Output, Input> {
  Future<Either<Failure, Output>> execute(Input input);
}
