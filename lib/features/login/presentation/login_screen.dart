import 'package:final_project/data/datasource/token_local_data_source.dart';
import 'package:final_project/data/repository/authorization.dart';
import 'package:final_project/features/login/bloc/sign_in/sign_in_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/bloc/auth/auth_bloc.dart';
import 'login.dart';

class LoginScreen extends StatelessWidget {
  final AuthBloc authBloc;
  const LoginScreen({super.key, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                SignInBloc(AuthorizationRepository(), DatasourceImpl())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginFormWidget(authBloc:authBloc),
      ),
    );
  }
}
