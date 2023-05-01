

import 'package:flutter/material.dart';

import '../../models/movie.dart';

@immutable
abstract class MovieEvent {}

class GetMoviesEvent extends MovieEvent{
  DateTime date;
  GetMoviesEvent({required this.date});
}

class GetMovieWithSessions extends MovieEvent{
  DateTime date;
  Movie movie;
  GetMovieWithSessions({required this.date, required this.movie});
}

