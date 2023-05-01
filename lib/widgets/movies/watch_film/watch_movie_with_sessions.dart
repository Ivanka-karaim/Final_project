
import 'package:flutter/material.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/movie/movie_bloc.dart';
import '../../../bloc/movie/movie_event.dart';
import '../../../models/movie.dart';

class WatchMovieWithSessions extends StatefulWidget{
  final AuthBloc authBloc;

  const WatchMovieWithSessions({super.key, required this.authBloc});

  @override
  State<WatchMovieWithSessions> createState() => _WatchMovieWithSessionsState();
}

class _WatchMovieWithSessionsState extends State<WatchMovieWithSessions> {
  late final MovieBloc movieBloc;
  late final Movie movie;
  late final DateTime date;

  @override
  void initState(){
    final Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    movie = arguments['movie'];
    // final bloc = arguments['bloc'] as MovieBloc;
    date = arguments['date'];
    movieBloc = MovieBloc();
    movieBloc.add(GetMovieWithSessions(date: date, movie: movie));
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Container(child: Text('${movie.name}'),);
  }
}