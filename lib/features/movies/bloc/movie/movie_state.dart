import 'package:final_project/features/movies/models/movie.dart';
import 'package:final_project/features/session/models/session.dart';
import 'package:flutter/material.dart';

@immutable
abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieSuccessful extends MovieState {
  List<Movie> movies;
  DateTime date;

  MovieSuccessful({required this.movies, required this.date});
}

class MovieSuccessfulWithSessions extends MovieState {
  Movie movie;
  List<Session> sessions;

  MovieSuccessfulWithSessions({required this.movie, required this.sessions});
}

class MovieFailure extends MovieState {
  final String error;

  MovieFailure({required this.error});
}
