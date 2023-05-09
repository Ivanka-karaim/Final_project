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
  late int cIndex;
  List<DateTime> dates = [];
  late final MovieBloc movieBloc;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    dates.add(now);
    for (int i = 0; i < 7; i++) {
      dates.add(dates[i].add(Duration(days: 1)));
    }
    movieBloc = MovieBloc();
    movieBloc.add(GetMoviesEvent(date: now));
    cIndex = 0;
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return TextButton(
                      onPressed: () {
                        setState(() {
                          cIndex = index;

                        });
                        movieBloc.add(GetMoviesEvent(date: dates[index]));

                      },
                      child: Date(
                        dateTime: dates[index],
                        isThisDate: index == cIndex,
                      ),
                    );
                  },
                  itemCount: 7),
            ),
          ),
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
