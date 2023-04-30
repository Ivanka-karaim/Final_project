import 'package:flutter/material.dart';

import '../../models/movie.dart';

@immutable
abstract class MovieState {}

class MovieInitial extends MovieState{}

class MovieSuccessful extends MovieState{
  List<Movie> movies;

  MovieSuccessful({required this.movies});
}

class MovieFailure extends MovieState{}