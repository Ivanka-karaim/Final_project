import 'package:flutter/material.dart';

import '../../models/movie.dart';

@immutable
abstract class FavouriteState {


}

class FavouriteInitial extends FavouriteState{
}

class FavouriteSuccessful extends FavouriteState{
  List<Movie> movies;
  FavouriteSuccessful({required this.movies});

}

class FavouriteFailure extends FavouriteState{}
