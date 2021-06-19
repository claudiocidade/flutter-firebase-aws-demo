part of 'authentication_bloc.dart';

abstract class AuthenticationState {}

class SignedOut extends AuthenticationState {}

class AuthenticationCanceled extends AuthenticationState {}

abstract class PhoneAuthenticationState extends AuthenticationState {
  final String phoneNumber;
  PhoneAuthenticationState({required this.phoneNumber});
}

class AuthenticationFailed extends AuthenticationState {
  final String message;
  AuthenticationFailed({required this.message});
}

class WaitingVerificationCode extends AuthenticationState {
  final String verificationId;
  WaitingVerificationCode({required this.verificationId});
}

class SignedIn extends PhoneAuthenticationState {
  final UserEntity currentUser;
  SignedIn({required this.currentUser})
      : super(phoneNumber: currentUser.phoneNumber);
}
