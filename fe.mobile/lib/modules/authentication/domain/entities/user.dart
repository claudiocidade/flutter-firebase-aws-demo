import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String phoneNumber;
  final String? name;
  final String? email;
  final bool? isOnline;
  final String status;
  final String? profileUrl;

  UserEntity({
    required this.phoneNumber,
    this.name,
    this.email,
    this.isOnline,
    this.status = "Hey there! I'm using mobile.",
    this.profileUrl,
  });

  @override
  List<Object> get props => [phoneNumber];
}
