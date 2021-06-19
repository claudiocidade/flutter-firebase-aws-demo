import 'package:get_it/get_it.dart';
import 'package:mobile/modules/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:mobile/modules/authentication/domain/usecases/verify_phone_number_usecase.dart';
import 'package:mobile/modules/authentication/domain/usecases/confirm_verification_usecase.dart';
import 'package:mobile/modules/authentication/domain/repositories/authentication_repository.dart';
import 'package:mobile/modules/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:mobile/modules/authentication/data/datasources/authentication_remote_datasource.dart';
import 'package:mobile/modules/authentication/data/datasources/firebase_authentication_remote_datasource_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => AuthenticationBloc(
      verifyPhoneNumberUseCase: sl(), confirmVerificationUseCase: sl()));

  sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => FirebaseAuthRemoteDataSourceImpl());

  sl.registerLazySingleton(() => VerifyPhoneNumberUseCase(sl()));
  sl.registerLazySingleton(() => ConfirmVerificationUseCase(sl()));
}
