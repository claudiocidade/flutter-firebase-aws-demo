import 'package:mobile/modules/user/domain/entities/user_entity.dart';
import 'package:mobile/modules/authentication/presentation/models/phone_info.dart';

abstract class AuthenticationState {
  final PhoneInfo? phoneInfo;
  final String? message;
  AuthenticationState({this.phoneInfo, this.message});
}

abstract class AuthenticationFailedState extends AuthenticationState {
  AuthenticationFailedState({PhoneInfo? phoneInfo, required String message})
    : super(phoneInfo: phoneInfo, message: message);
}

class SignedOutState extends AuthenticationState {
  SignedOutState({PhoneInfo? phoneInfo}) 
    : super(phoneInfo: phoneInfo);
}

class SignInFailedState extends AuthenticationFailedState {
  SignInFailedState({required String message}) 
    : super(message: message);
}

class VerificationFailedState extends AuthenticationFailedState {
  VerificationFailedState({required PhoneInfo phoneInfo, required String message}) 
    : super(phoneInfo: phoneInfo, message: message);
}

class WaitingSignInResponseState extends AuthenticationState {
  WaitingSignInResponseState({required PhoneInfo phoneInfo});
}

class WaitingVerificationPinCodeState extends AuthenticationState {
  final String verificationId;
  WaitingVerificationPinCodeState({
    PhoneInfo? phoneInfo,
    required this.verificationId})
    : super(phoneInfo: phoneInfo);
}

class SignedInState extends AuthenticationState {
  final UserEntity currentUser;
  SignedInState({required this.currentUser})
    : super(phoneInfo: currentUser.phoneInfo);
}