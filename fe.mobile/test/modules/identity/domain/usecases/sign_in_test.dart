// import 'package:dartz/dartz.dart';
// import 'package:mockito/mockito.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mobile/modules/identity/domain/entities/user.dart';
// import 'package:mobile/modules/identity/domain/repositories/authentication_repository.dart';
// import 'package:mobile/modules/identity/domain/usecases/sign_in_usecase.dart';

// class MockAuthenticationRepository extends Mock
//     implements IAuthenticationRepository {}

// void main() {
//   late SignInUseCase usecase;
//   late MockAuthenticationRepository repository;

//   final phonenumber = "+13214445555";
//   final result = UserEntity(phoneNumber: phonenumber);

//   setUp(() {
//     repository = MockAuthenticationRepository();
//     usecase = SignInUseCase(repository);
//   });

//   test('should sign user in using the phonenumber', () async {
//     when(repository.signIn(any)).thenAnswer((_) async => Right(result));
//   });
// }
