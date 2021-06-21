part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {}

class OnPhoneVerificationRequested extends AuthenticationEvent {
  final String phoneNumber;
  OnPhoneVerificationRequested({required this.phoneNumber});
}

class OnPhoneVerificationSubmitted extends AuthenticationEvent {
  final String verificationId;
  final String smsCode;
  OnPhoneVerificationSubmitted(
      {required this.verificationId, required this.smsCode});
}

class OnPhoneVerificationCompleted extends AuthenticationEvent {
  final AuthCredential credential;
  OnPhoneVerificationCompleted({required this.credential});
}

class OnPhoneVerificationFailed extends AuthenticationEvent {
  final String message;
  OnPhoneVerificationFailed({required this.message});
}

class OnPhoneVerificationCodeSent extends AuthenticationEvent {
  final String verificationId;
  final int? forceResendingToken;
  OnPhoneVerificationCodeSent(
      {required this.verificationId, required this.forceResendingToken});
}

class OnPhoneCodeAutoRetrievalTimeout extends AuthenticationEvent {
  final String verificationId;
  OnPhoneCodeAutoRetrievalTimeout({required this.verificationId});
}

class OnSignOutRequested extends AuthenticationEvent {
  OnSignOutRequested();
}
