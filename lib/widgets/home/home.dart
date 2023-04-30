import 'package:final_project/bloc/home/home_bloc.dart';
import 'package:final_project/widgets/home/home_provider.dart';
import 'package:final_project/widgets/movies/movie.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/home/home_state.dart';
import '../../bloc/profile/profile_bloc.dart';




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
