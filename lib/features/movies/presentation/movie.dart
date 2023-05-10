import 'package:final_project/features/home/bloc/favourite/favourite_bloc.dart';
import 'package:final_project/features/home/bloc/favourite/favourite_event.dart';
import 'package:final_project/features/movies/bloc/movie/movie_bloc.dart';
import 'package:final_project/features/movies/bloc/movie/movie_event.dart';
import 'package:final_project/features/movies/bloc/movie/movie_state.dart';
import 'package:final_project/features/movies/presentation/watch_film/movie_one_part.dart';
import 'package:final_project/features/movies/presentation/watch_film/watch_movie_with_sessions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../error.dart';

import '../../home/presentation/home_general/circular.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> with TickerProviderStateMixin {
  late final MovieBloc movieBloc;
  late final FavouriteBloc favouriteBloc;

  @override
  void initState() {
    super.initState();

    movieBloc = MovieBloc();
    movieBloc.add(GetMoviesEvent(date: DateTime.now()));
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
              bloc: movieBloc,
              builder: (context, state) {
                return state is MovieInitial
                    ? const Expanded(child: Circular())
                    : state is MovieSuccessful
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
                                                date: state.date),
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
              listener: (context, state) {
                if (state is MovieFailure) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ErrorPage(error: state.error)),
                  );
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                }
              }),
        ],
      ),
    );
  }
}
