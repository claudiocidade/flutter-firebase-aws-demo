import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:mobile/modules/authentication/presentation/bloc/authentication_bloc.dart';

class VerifyPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
      if (state is WaitingVerificationCode) {
        print(state.verificationId);
      }
    }, builder: (context, state) {
      return Material(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Enter the 6-digits Pin Code'),
                    PinCodeTextField(
                        controller: controller,
                        appContext: context,
                        length: 6,
                        onChanged: (value) {}),
                    ElevatedButton(
                        child: Text('CONFIRM'),
                        onPressed: () {
                          print(
                              "Submitting verification code ${(state as WaitingVerificationCode).verificationId}");
                          BlocProvider.of<AuthenticationBloc>(context).add(
                              OnPhoneVerificationSubmitted(
                                  verificationId: state.verificationId,
                                  smsCode: controller.text));
                        }),
                    ElevatedButton(
                      child: Text('CANCEL'),
                      onPressed: () {
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(OnSignOutRequested());
                      },
                    )
                  ])));
    });
  }
}
