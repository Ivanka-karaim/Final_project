import 'package:flutter/material.dart';

import '../../../movies/models/movie.dart';

@immutable
abstract class FavouriteEvent{

}

class AddFavouriteMovieEvent extends FavouriteEvent{
  final Movie movie;
  AddFavouriteMovieEvent({required this.movie});
}

class GetFavouriteMovieEvent extends FavouriteEvent{}
class DeleteMovieEvent extends FavouriteEvent{
  final Movie movie;
  DeleteMovieEvent({required this.movie});
}