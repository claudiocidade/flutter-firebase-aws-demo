import 'package:mobile/modules/authentication/domain/entities/user.dart';

class UserModel extends UserEntity {
  UserModel({required String phoneNumber}) : super(phoneNumber: phoneNumber);

  factory UserModel.fromJson(Map<String, String> json) {
    return UserModel(phoneNumber: json['phoneNumber']!);
  }

  Map<String, dynamic> toJson() {
    return {'phoneNumber': phoneNumber};
  }
}
