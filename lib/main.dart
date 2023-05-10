import 'package:final_project/features/home/bloc/auth/auth_state.dart';
import 'package:final_project/data/datasource/token_local_data_source.dart';
import 'package:final_project/features/home/presentation/home.dart';
import 'package:final_project/features/home/presentation/home_general/circular.dart';
import 'package:final_project/features/login/presentation/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/home/bloc/auth/auth_bloc.dart';
import 'features/home/bloc/auth/auth_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthBloc authBloc;

  Future checkIfAuthorized() async {
    DatasourceImpl();
    authBloc.add(CheckUserEvent());
  }

  @override
  void initState() {
    authBloc = AuthBloc();
    authBloc.add(CheckUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: authBloc,
        builder: (context, state) {
          return state is AuthInitial? const MaterialApp(home:Circular()):state is AuthSuccessful
              ? HomePage(
                  authBloc: authBloc,
                )
              : const LoginScreen();
        },
        listener: (context, state) {

        });
  }
}
