import 'package:final_project/features/home/bloc/auth/auth_bloc.dart';
import 'package:final_project/features/home/bloc/home/home_bloc.dart';
import 'package:final_project/features/home/presentation/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../profile/bloc/profile/profile_bloc.dart';




class HomePage extends StatelessWidget {
  final AuthBloc authBloc;

  const HomePage({super.key, required this.authBloc});



  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
        BlocProvider(create: (context) => HomeBloc()),
    ],
    child: HomeProvider(authBloc: authBloc),
    );
  }
}
