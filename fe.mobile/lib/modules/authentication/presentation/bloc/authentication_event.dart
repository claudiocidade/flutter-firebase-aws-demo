import 'package:mobile/core/bloc/event.dart';
import 'package:mobile/modules/authentication/presentation/models/phone_info.dart';

abstract class PhoneAuthenticationEvent extends BlocEvent {
  final PhoneInfo? phoneInfo;
  PhoneAuthenticationEvent({this.phoneInfo, String? eventMessage}) 
    : super(eventMessage: eventMessage);
}

abstract class PhoneVerificationEvent extends PhoneAuthenticationEvent {
  final String verificationId;
  PhoneVerificationEvent({PhoneInfo? phoneInfo,required this.verificationId}) 
    : super(phoneInfo: phoneInfo);
}

class OnVerifyPhoneNumber extends PhoneAuthenticationEvent {
  OnVerifyPhoneNumber({required PhoneInfo phoneInfo})
    : super(phoneInfo: phoneInfo);
}

class OnConfirmPhoneNumber extends PhoneVerificationEvent {
  final String smsCode;
  OnConfirmPhoneNumber({PhoneInfo? phoneInfo, required String verificationId, required this.smsCode})
    : super(phoneInfo: phoneInfo, verificationId: verificationId);
}

class OnVerificationCodeSent extends PhoneVerificationEvent {
  OnVerificationCodeSent({PhoneInfo? phoneInfo, required String verificationId}) 
    : super(phoneInfo: phoneInfo, verificationId: verificationId);
}

class OnVerificationFailed extends PhoneAuthenticationEvent {
  OnVerificationFailed({required String eventMessage}) 
    : super(eventMessage: eventMessage);
}

class OnVerificationCompleted extends PhoneAuthenticationEvent {
  final String refreshToken;
  OnVerificationCompleted({
    required PhoneInfo phoneInfo, 
    required this.refreshToken
  }) : super(phoneInfo: phoneInfo);
}

class OnVerificationAutoRetrievalTimeOut extends PhoneVerificationEvent {
  OnVerificationAutoRetrievalTimeOut({ PhoneInfo? phoneInfo, required String verificationId }) 
    : super(phoneInfo: phoneInfo, verificationId: verificationId);
}

class OnSignOutRequested extends PhoneAuthenticationEvent {
  OnSignOutRequested({PhoneInfo? phoneInfo}) 
  : super(phoneInfo: phoneInfo);
}
