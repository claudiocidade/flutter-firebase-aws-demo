import 'package:equatable/equatable.dart';
import 'package:mobile/modules/authentication/presentation/models/phone_info.dart';

class UserEntity extends Equatable {
  final PhoneInfo phoneInfo;
  final String? name;
  final String? email;
  final bool? isOnline;
  final String status;
  final String? profileUrl;

  UserEntity({
    required this.phoneInfo,
    this.name,
    this.email,
    this.isOnline,
    this.status = "Hey there! I'm using mobile.",
    this.profileUrl,
  });

  @override
  List<Object> get props => [phoneInfo];
}
