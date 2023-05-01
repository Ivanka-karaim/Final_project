
import 'package:final_project/widgets/movies/movie.dart';
import 'package:final_project/widgets/movies/watch_film/watch_movie_with_sessions.dart';
import 'package:flutter/material.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../profile/profile.dart';

class MovieNavigator extends StatelessWidget{
  final AuthBloc authBloc;
  const MovieNavigator({super.key, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MoviePage(authBloc: authBloc),
        '/movie' : (context) => WatchMovieWithSessions(authBloc: authBloc),
      },
    );
  }

}