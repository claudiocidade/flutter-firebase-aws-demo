import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile/modules/application/presentation/pages/home_page.dart';
import 'package:mobile/modules/authentication/presentation/pages/signin_page.dart';
import 'package:mobile/modules/authentication/presentation/pages/verify_page.dart';
import 'package:mobile/modules/application/presentation/bloc/application_bloc.dart';
import 'package:mobile/modules/authentication/presentation/bloc/authentication_bloc.dart';

import 'dependency_injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationBloc>(
                create: (context) => di.sl<AuthenticationBloc>()),
            BlocProvider<ApplicationBloc>(
                create: (context) => di.sl<ApplicationBloc>()),
          ],
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                if (state is SignedOut) {
                  return SignInPage();
                } else if (state is WaitingVerificationCode) {
                  return VerifyPage();
                }
                return HomePage();
              })));
}
