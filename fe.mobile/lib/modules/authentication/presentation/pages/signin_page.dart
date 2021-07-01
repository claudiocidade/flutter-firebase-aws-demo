import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/modules/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:mobile/modules/authentication/presentation/bloc/authentication_event.dart';
import 'package:mobile/modules/authentication/presentation/models/phone_info.dart';

class SignInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final List<String> _favoriteCountries = <String>['US', 'BR'];
  final String _defaultPhoneNumberLabelText = 'Enter your area code + phone number';

  String? _phoneNumber;                 
  String? _selectedCountryIsoCode = "US";
  String? _selectedCountryDialCode = "+1";

  @override
  void initState() {
    super.initState();
    final state = this.context.read<AuthenticationBloc>().state;
    if (state.phoneInfo != null) {
      this._phoneNumber = state.phoneInfo!.dialNumber;
      this._selectedCountryDialCode = state.phoneInfo!.dialCode;
      this._selectedCountryIsoCode = state.phoneInfo!.dialCode;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            Row(children: [
              Expanded(
                child: CountryCodePicker(
                initialSelection: this._selectedCountryIsoCode,
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                showDropDownButton: false,
                alignLeft: true,
                favorite: this._favoriteCountries,
                onChanged: (value) {
                  setState(() {
                    this._selectedCountryIsoCode = value.code;
                    this._selectedCountryDialCode = value.dialCode;
                  });
                },
              )),
              Expanded(
                flex: 2,
                child: TextFormField(
                  decoration: InputDecoration(labelText: this._defaultPhoneNumberLabelText),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  initialValue: this._phoneNumber,
                  onChanged: (value) {
                    setState(() {
                      this._phoneNumber = value;
                    });
                  },
                )
              )
            ]),
            ElevatedButton(
              autofocus: true,
              onPressed: () => 
                BlocProvider
                  .of<AuthenticationBloc>(context)
                  .add(OnVerifyPhoneNumber(
                    phoneInfo: PhoneInfo(
                      isoCode: this._selectedCountryIsoCode!, 
                      dialCode: this._selectedCountryDialCode!, 
                      dialNumber: this._phoneNumber!))),
              child: Text("SEND CODE"))
          ])));
  }
}