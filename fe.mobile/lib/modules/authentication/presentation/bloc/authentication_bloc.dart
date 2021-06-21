import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/modules/authentication/domain/entities/user.dart';
import 'package:mobile/modules/authentication/domain/usecases/check_is_signed_in_usecase.dart';
import 'package:mobile/modules/authentication/domain/usecases/confirm_verification_usecase.dart';
import 'package:mobile/modules/authentication/domain/usecases/phone_verification_confirmation_input.dart';
import 'package:mobile/modules/authentication/domain/usecases/phone_verification_input.dart';
import 'package:mobile/modules/authentication/domain/usecases/verify_phone_number_usecase.dart';
import 'package:mobile/modules/authentication/errorhandling/authentication_failure.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final VerifyPhoneNumberUseCase verifyPhoneNumberUseCase;
  final ConfirmVerificationUseCase confirmVerificationUseCase;
  final CheckSignedInUseCase checkSignedInUseCase;

  AuthenticationBloc(
      {required this.verifyPhoneNumberUseCase,
      required this.confirmVerificationUseCase,
      required this.checkSignedInUseCase})
      : super(SignedOut());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    print(event);
    if (event is OnPhoneVerificationRequested) {
      final result = await this
          .verifyPhoneNumberUseCase
          .execute(this._createPhoneVerificationInput(event.phoneNumber));
      result.fold((failure) => null, (_) => _);
      yield PhoneVerificationPending();
    }

    if (event is OnPhoneVerificationSubmitted) {
      final result = await this.confirmVerificationUseCase.execute(
          PhoneVerificationConfirmationRequest(
              verificationId: event.verificationId, smsCode: event.smsCode));
      result.fold(
          (failure) => add(OnPhoneVerificationFailed(
              message: failure is FirebaseAuthenticationFailure
                  ? failure.exception.message!
                  : failure.message)),
          (success) => print(success));
      yield SignedIn(currentUser: UserEntity(phoneNumber: event.smsCode));
    }

    if (event is OnPhoneVerificationFailed)
      yield AuthenticationFailed(message: event.message);

    if (event is OnPhoneVerificationCodeSent)
      yield WaitingVerificationCode(verificationId: event.verificationId);

    if (event is OnSignOutRequested) yield SignedOut();
  }

  PhoneVerificationRequest _createPhoneVerificationInput(String phoneNumber) {
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) {
      add(OnPhoneVerificationCompleted(credential: credential));
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      add(OnPhoneVerificationFailed(message: exception.message!));
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

    return PhoneVerificationRequest(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }
}
