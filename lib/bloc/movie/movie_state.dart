import 'package:flutter/material.dart';

import '../../models/movie.dart';
import '../../models/session.dart';

@immutable
abstract class MovieState {}

class MovieInitial extends MovieState{}

class MovieSuccessful extends MovieState{
  List<Movie> movies;
  DateTime date;

  MovieSuccessful({required this.movies, required this.date});
}

class MovieSuccessfulWithSessions extends MovieState {
  Movie movie;
  List<Session> sessions;

  MovieSuccessfulWithSessions({required this.movie, required this.sessions});
}

class MovieFailure extends MovieState{
  final String error;
  MovieFailure({required this.error});
}