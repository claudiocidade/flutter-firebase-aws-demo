import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_code_picker/country_code_picker.dart';

class PhoneVerificationFormField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<CountryCode>? onChanged;
  final String labelText;
  final List<String> favorite = ['US'];

  final String initialValue;

  PhoneVerificationFormField(
      {required this.controller,
      required this.labelText,
      required this.initialValue,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Row(children: [
      Expanded(
          child: CountryCodePicker(
        initialSelection: this.initialValue,
        showCountryOnly: false,
        showOnlyCountryWhenClosed: false,
        showDropDownButton: false,
        alignLeft: true,
        favorite: this.favorite,
        onChanged: this.onChanged,
      )),
      Expanded(
          flex: 2,
          child: TextFormField(
              controller: controller,
              decoration: InputDecoration(labelText: this.labelText),
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ])),
    ]));
  }
}
