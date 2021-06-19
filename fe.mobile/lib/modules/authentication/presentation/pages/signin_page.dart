import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/modules/authentication/presentation/bloc/authentication_bloc.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final phoneNumberController = TextEditingController();
    return Material(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextFormField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.phone_iphone),
                      labelText: "Enter your phone number"),
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ]),
              Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              ElevatedButton(
                  onPressed: () => {
                        BlocProvider.of<AuthenticationBloc>(context).add(
                            OnPhoneVerificationRequested(
                                phoneNumber: "+${phoneNumberController.text}"))
                      },
                  child: Text("SEND CODE")),
            ])));
  }
}
