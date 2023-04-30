

import 'package:flutter/material.dart';

@immutable
abstract class MovieEvent {}

class GetMoviesEvent extends MovieEvent{
  DateTime date;

  GetMoviesEvent({required this.date});
}

