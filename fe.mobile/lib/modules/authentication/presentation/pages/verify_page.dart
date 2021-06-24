import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:mobile/modules/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:mobile/modules/authentication/presentation/bloc/authentication_state.dart';
import 'package:mobile/modules/authentication/presentation/bloc/authentication_event.dart';


class VerifyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  String? smsCode;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Enter the 6-digits Pin Code'),
            PinCodeTextField(
              autoFocus: true,
              appContext: context,
              length: 6,
              onChanged: (value) {
                setState(() {
                  this.smsCode = value;
                });
              }),
            ElevatedButton(
              child: Text('CONFIRM'),
              onPressed: () {
                final state = 
                  context.read<AuthenticationBloc>().state 
                    as WaitingVerificationPinCodeState;
                BlocProvider
                  .of<AuthenticationBloc>(context)
                  .add(OnConfirmPhoneNumber(
                    verificationId: state.verificationId, 
                    smsCode: this.smsCode!));
              }),
            ElevatedButton(
              child: Text('CANCEL'),
              onPressed: () =>
                BlocProvider
                  .of<AuthenticationBloc>(context)
                  .add(OnSignOutRequested()),
            )
          ])));
  }
}
