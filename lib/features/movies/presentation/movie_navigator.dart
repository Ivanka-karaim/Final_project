import 'package:final_project/features/home/bloc/favourite/favourite_bloc.dart';
import 'package:final_project/features/movies/presentation/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/bloc/auth/auth_bloc.dart';
import '../bloc/movie/movie_bloc.dart';


class MovieNavigator extends StatelessWidget {
  const MovieNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MovieBloc()),
        BlocProvider(create: (context) => FavouriteBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => MoviePage(),
        },
      ),
    );
  }
}
