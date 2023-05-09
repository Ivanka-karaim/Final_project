

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/favourite/favourite_bloc.dart';
import '../bloc/favourite/favourite_event.dart';
import '../bloc/favourite/favourite_state.dart';
import 'circular.dart';
import 'movies/watch_film/movie_one_part.dart';
import 'movies/watch_film/watch_movie_with_sessions.dart';

class FavouriteMovies extends StatefulWidget{
  @override
  State<FavouriteMovies> createState() => _FavouriteMoviesState();
}

class _FavouriteMoviesState extends State<FavouriteMovies> {
  late final FavouriteBloc favouriteBloc;

  @override
  void initState(){
    super.initState();
    favouriteBloc = FavouriteBloc();
    favouriteBloc.add(GetFavouriteMovieEvent());
  }

  @override
  Widget build(BuildContext context) {
    print(9999);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height:30),
          Text('Ваші вподобані фільми', style: TextStyle(color: Colors.white,fontSize: 30, fontWeight: FontWeight.w400,  ),),
          SizedBox(height:30),
          IconButton(onPressed: (){
            setState(() {
              favouriteBloc.add(GetFavouriteMovieEvent());
            });
          }, icon: Icon(Icons.update_rounded, color: Colors.deepPurple,),),
          BlocConsumer(
              bloc: favouriteBloc,
              builder: (context, state) {
                return state is  FavouriteInitial?Expanded(child:Circular()):state is FavouriteSuccessful
                    ? Expanded(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WatchMovieWithSessions(
                                      movie: state.movies[index],
                                      date: DateTime.now()),
                            ),
                          );
                        },
                        child: MovieOnePart(
                          movie: state.movies[index],favouriteBloc:favouriteBloc,
                        ),
                      );
                    },
                    itemCount: state.movies.length,
                  ),
                )
                    :Text('error');
              },
              listener: (context, state) {

              }),
        ],
      ),
    );
  }
}