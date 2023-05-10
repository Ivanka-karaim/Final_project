import 'package:final_project/features/movies/models/movie.dart';
import 'package:flutter/material.dart';



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
