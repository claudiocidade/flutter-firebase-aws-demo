import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/modules/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:mobile/modules/authentication/presentation/bloc/authentication_state.dart';
import 'package:mobile/modules/authentication/presentation/pages/signin_page.dart';
import 'package:mobile/modules/authentication/presentation/pages/verify_page.dart';

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) => 
          ScaffoldMessenger
            .of(context)
            .showSnackBar(SnackBar(
              content: Text((state as AuthenticationFailedState).message!))),
        listenWhen: (prevState, currState) => currState is AuthenticationFailedState,
        builder: (context, state) {
          if (state is SignedOutState) return SignInPage();
          if (state is WaitingVerificationPinCodeState) return VerifyPage();
          if (state is WaitingSignInResponseState) return CircularProgressIndicator();
          return Material();
        }));
  }
}