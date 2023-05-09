import 'package:final_project/bloc/movie/movie_event.dart';
import 'package:final_project/bloc/movie/movie_state.dart';
import 'package:final_project/widgets/movies/watch_film/date.dart';
import 'package:final_project/widgets/movies/watch_film/movie_one_part.dart';
import 'package:final_project/widgets/movies/watch_film/watch_movie_with_sessions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/movie/movie_bloc.dart';
import '../circular.dart';
import '../home/home.dart';

class MoviePage extends StatefulWidget {


  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> with TickerProviderStateMixin {
  late final MovieBloc movieBloc;

  @override
  void initState() {
    super.initState();

    movieBloc = MovieBloc();
    movieBloc.add(GetMoviesEvent(date: DateTime.now()));

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          BlocConsumer(
              bloc: movieBloc,
              builder: (context, state) {
                return state is MovieFailure? HomePage(authBloc: AuthBloc())
                    : state is MovieSuccessful
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
                                                date: state.date),
                                      ),
                                    );
                                  },
                                  child: MovieOnePart(
                                    movie: state.movies[index],
                                  ),
                                );
                              },
                              itemCount: state.movies.length,
                            ),
                          )
                        :Expanded(child:Circular());
              },
              listener: (context, state) {}),
        ],
      ),
    );
  }
}
