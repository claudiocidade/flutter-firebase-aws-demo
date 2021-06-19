import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/core/error/failure.dart';

class AuthenticationFailure extends Failure {
  final FirebaseAuthException exception;
  AuthenticationFailure({required this.exception})
      : super(message: exception.message!);
}
