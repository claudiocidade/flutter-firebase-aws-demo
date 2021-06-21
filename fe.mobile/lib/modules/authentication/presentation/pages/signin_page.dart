import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/modules/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:mobile/modules/authentication/presentation/widgets/phone_verification_input.dart';

class SignInPage extends StatelessWidget {
  String selectedCountryCode = "";

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final Locale locale = WidgetsBinding.instance!.window.locale;

    return Material(
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) => ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Authentication Failed"))),
            listenWhen: (previousState, currentState) =>
                previousState is WaitingVerificationCode &&
                currentState is AuthenticationFailed,
            builder: (context, state) {
              if (state is SignedOut)
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: PhoneVerificationFormField(
                              controller: controller,
                              initialValue: locale.countryCode ?? 'US',
                              labelText: "Enter your phone number",
                              onChanged: (value) {
                                selectedCountryCode = value.dialCode!;
                              })),
                      ElevatedButton(
                          autofocus: true,
                          onPressed: () => {
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .add(OnPhoneVerificationRequested(
                                        phoneNumber:
                                            "+${selectedCountryCode}${controller.text}"))
                              },
                          child: Text("SEND CODE")),
                    ]);
              return CircularProgressIndicator();
            }));
  }
}
