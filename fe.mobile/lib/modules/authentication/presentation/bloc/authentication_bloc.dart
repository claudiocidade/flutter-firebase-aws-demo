import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/modules/authentication/domain/entities/user.dart';
import 'package:mobile/modules/authentication/domain/usecases/confirm_verification_usecase.dart';
import 'package:mobile/modules/authentication/domain/usecases/phone_verification_confirmation_input.dart';
import 'package:mobile/modules/authentication/domain/usecases/phone_verification_input.dart';
import 'package:mobile/modules/authentication/domain/usecases/verify_phone_number_usecase.dart';
import 'package:mobile/modules/authentication/errorhandling/authentication_failure.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

/// https://stackoverflow.com/questions/64498786/stuck-returning-verificationid-from-futurestring-method-flutter/64517609#64517609
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final VerifyPhoneNumberUseCase verifyPhoneNumberUseCase;
  final ConfirmVerificationUseCase confirmVerificationUseCase;

  AuthenticationBloc(
      {required this.verifyPhoneNumberUseCase,
      required this.confirmVerificationUseCase})
      : super(SignedOut());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    print(event);
    if (event is OnPhoneVerificationRequested)
      this
          .verifyPhoneNumberUseCase
          .execute(this._createPhoneVerificationInput(event.phoneNumber));

    if (event is OnPhoneVerificationSubmitted) {
      final result = await this.confirmVerificationUseCase.execute(
          PhoneVerificationConfirmationInput(
              verificationId: event.verificationId, smsCode: event.smsCode));
      result.fold(
          (failure) => add(OnPhoneVerificationFailed(
              exception: (failure as AuthenticationFailure).exception)),
          (success) => print(success));
      yield SignedIn(currentUser: UserEntity(phoneNumber: event.smsCode));
    }

    if (event is OnPhoneVerificationFailed)
      yield AuthenticationFailed(message: event.exception.message!);

    if (event is OnPhoneVerificationCodeSent)
      yield WaitingVerificationCode(verificationId: event.verificationId);

    if (event is OnSignOutRequested) yield SignedOut();
  }

  PhoneVerificationInput _createPhoneVerificationInput(String phoneNumber) {
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) {
      add(OnPhoneVerificationCompleted(credential: credential));
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      add(OnPhoneVerificationFailed(exception: exception));
    };

    final PhoneCodeSent codeSent =
        (String verificationId, int? forceResendingToken) {
      add(OnPhoneVerificationCodeSent(
          verificationId: verificationId,
          forceResendingToken: forceResendingToken));
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      add(OnPhoneCodeAutoRetrievalTimeout(verificationId: verificationId));
    };

    return PhoneVerificationInput(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }
}
