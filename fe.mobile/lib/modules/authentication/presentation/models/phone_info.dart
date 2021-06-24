import 'package:equatable/equatable.dart';

class PhoneInfo extends Equatable {
  final String isoCode;
  final String dialCode;
  final String dialNumber;
  PhoneInfo({required this.isoCode, required this.dialCode, required this.dialNumber});

  @override
  List<Object?> get props => [isoCode, dialCode, dialNumber];

  @override
  String toString() => "+${this.dialCode.replaceAll('+', '')}${this.dialNumber}";
}