import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/modules/authentication/domain/usecases/sign_out_usecase.dart';
import 'package:mobile/modules/authentication/presentation/bloc/authentication_event.dart';
import 'package:mobile/modules/authentication/presentation/bloc/authentication_state.dart';
import 'package:mobile/modules/authentication/domain/usecases/phone_verification_request.dart';
import 'package:mobile/modules/authentication/domain/usecases/check_is_signed_in_usecase.dart';
import 'package:mobile/modules/authentication/domain/usecases/verify_phone_number_usecase.dart';
import 'package:mobile/modules/authentication/domain/usecases/confirm_verification_usecase.dart';
import 'package:mobile/modules/authentication/domain/usecases/phone_verification_confirmation_request.dart';
import 'package:mobile/modules/authentication/presentation/models/phone_info.dart';
import 'package:mobile/modules/user/domain/entities/user_entity.dart';

class AuthenticationBloc
  extends Bloc<PhoneAuthenticationEvent, AuthenticationState> {
  final VerifyPhoneNumberUseCase verifyPhoneNumberUseCase;
  final ConfirmVerificationUseCase confirmVerificationUseCase;
  final CheckSignedInUseCase checkSignedInUseCase;
  final SignOutUseCase signOutUseCase;

  AuthenticationBloc({
    required this.verifyPhoneNumberUseCase,
    required this.confirmVerificationUseCase,
    required this.checkSignedInUseCase,
    required this.signOutUseCase})
    : super(SignedOutState());

  @override
  Stream<AuthenticationState> mapEventToState(
    PhoneAuthenticationEvent event) async* {
    print(event);
    if (event is OnVerifyPhoneNumber) {
      final result = await this.verifyPhoneNumberUseCase.execute(
        this._createPhoneVerificationInput(
          phoneInfo: event.phoneInfo!));
      result.fold(
        (failure) => add(OnVerificationFailed(eventMessage: failure.message)),
        (_) => _);
      yield WaitingSignInResponseState(phoneInfo: event.phoneInfo!);
    }

    if (event is OnConfirmPhoneNumber) {
      final result = 
        await this.confirmVerificationUseCase.execute(
          PhoneVerificationConfirmationRequest(
            verificationId: event.verificationId, 
            smsCode: event.smsCode));
      result.fold(
        (failure) => add(OnVerificationFailed(eventMessage: failure.message)), 
        (success) => add(OnVerificationCompleted(
          phoneInfo: event.phoneInfo!, 
          refreshToken: success.refreshToken!)));
    }

    if (event is OnVerificationFailed) {
      print(event.eventMessage);
      yield SignedOutState(phoneInfo: event.phoneInfo, message: event.eventMessage ?? "");
    }

    if (event is OnVerificationCodeSent)
      yield WaitingVerificationPinCodeState(
        phoneInfo: event.phoneInfo,
        verificationId: event.verificationId);

    if (event is OnVerificationCompleted)
      yield SignedInState(currentUser:
        UserEntity(phoneInfo: event.phoneInfo!));

    if (event is OnSignOutRequested)
      yield SignedOutState(phoneInfo: event.phoneInfo, );
  }

  PhoneVerificationRequest _createPhoneVerificationInput({required PhoneInfo phoneInfo}) {
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
          final result = await this.confirmVerificationUseCase.execute(
            PhoneVerificationConfirmationRequest(
              verificationId: credential.verificationId!, 
              smsCode: credential.smsCode!));
          result.fold(
            (failure) => add(OnVerificationFailed(
              eventMessage: failure.message)),
            (success) => add(OnVerificationCompleted(
              phoneInfo: phoneInfo, 
              refreshToken: success.refreshToken!)));
      };

    final PhoneVerificationFailed verificationFailed =
      (FirebaseAuthException exception) =>
        add(OnVerificationFailed(eventMessage: exception.message!));

    final PhoneCodeSent codeSent =
      (String verificationId, int? forceResendingToken) =>
        add(OnVerificationCodeSent(
          phoneInfo: phoneInfo,
          verificationId: verificationId));

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
      (String verificationId) =>
        add(OnVerificationAutoRetrievalTimeOut(
          phoneInfo: phoneInfo,
          verificationId: verificationId));

    return PhoneVerificationRequest(
        phoneInfo: phoneInfo,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }
}
