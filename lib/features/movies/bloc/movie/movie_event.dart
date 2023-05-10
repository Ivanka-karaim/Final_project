import 'package:final_project/features/movies/models/movie.dart';
import 'package:flutter/material.dart';

@immutable
abstract class MovieEvent {}

class GetMoviesEvent extends MovieEvent {
  DateTime date;

  GetMoviesEvent({required this.date});
}

class GetMovieWithSessions extends MovieEvent {
  DateTime date;
  Movie movie;

  GetMovieWithSessions({required this.date, required this.movie});
}
