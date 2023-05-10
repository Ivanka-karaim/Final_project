import 'package:final_project/features/home/bloc/favourite/favourite_bloc.dart';
import 'package:final_project/features/home/bloc/favourite/favourite_event.dart';
import 'package:final_project/features/home/bloc/favourite/favourite_state.dart';
import 'package:final_project/features/movies/presentation/watch_film/movie_one_part.dart';
import 'package:final_project/features/movies/presentation/watch_film/watch_movie_with_sessions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_general/circular.dart';

class FavouriteMovies extends StatefulWidget {
  const FavouriteMovies({super.key});

  @override
  State<FavouriteMovies> createState() => _FavouriteMoviesState();
}

class _FavouriteMoviesState extends State<FavouriteMovies> {
  late final FavouriteBloc favouriteBloc;

  @override
  void initState() {
    super.initState();
    favouriteBloc = FavouriteBloc();
    favouriteBloc.add(GetFavouriteMovieEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 30),
          const Text(
            'Ваші вподобані фільми',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 30),
          IconButton(
            onPressed: () {
              setState(() {
                favouriteBloc.add(GetFavouriteMovieEvent());
              });
            },
            icon: const Icon(
              Icons.update_rounded,
              color: Colors.deepPurple,
            ),
          ),
          BlocConsumer(
              bloc: favouriteBloc,
              builder: (context, state) {
                return state is FavouriteInitial
                    ? const Expanded(child: Circular())
                    : state is FavouriteSuccessful
                        ? Expanded(
                            child: ListView.builder(
                              itemBuilder: (BuildContext context, int index) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black),
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
                                    movie: state.movies[index],
                                    favouriteBloc: favouriteBloc,
                                  ),
                                );
                              },
                              itemCount: state.movies.length,
                            ),
                          )
                        : const Text('error');
              },
              listener: (context, state) {}),
        ],
      ),
    );
  }
}
