import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/core/error/failure.dart';

class UnhandledAuthenticationFailure extends Failure {
  final Exception exception;
  UnhandledAuthenticationFailure({required this.exception})
      : super(message: exception.toString());
}

class FirebaseAuthenticationFailure extends Failure {
  final FirebaseAuthException exception;
  FirebaseAuthenticationFailure({required this.exception})
      : super(message: exception.message!);
}
