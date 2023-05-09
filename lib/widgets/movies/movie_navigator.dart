import 'package:final_project/bloc/favourite/favourite_bloc.dart';
import 'package:final_project/widgets/movies/movie.dart';
import 'package:final_project/widgets/movies/watch_film/watch_movie_with_sessions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/movie/movie_bloc.dart';
import '../profile/profile.dart';

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
          // '/movie' : (context) => WatchMovieWithSessions(authBloc: authBloc),
        },
      ),
    );
  }
}
