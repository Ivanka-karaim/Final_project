import 'package:final_project/widgets/movies/session/session.dart';
import 'package:final_project/widgets/movies/watch_film/session_in_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/movie/movie_bloc.dart';
import '../../../bloc/movie/movie_event.dart';
import '../../../bloc/movie/movie_state.dart';
import '../../../models/movie.dart';
import '../../circular.dart';
import 'age.dart';

class WatchMovieWithSessions extends StatefulWidget {
  final AuthBloc authBloc;
  final Movie movie;
  final DateTime date;

  const WatchMovieWithSessions(
      {super.key,
      required this.authBloc,
      required this.movie,
      required this.date});

  @override
  State<WatchMovieWithSessions> createState() => _WatchMovieWithSessionsState();
}

class _WatchMovieWithSessionsState extends State<WatchMovieWithSessions> {
  late final MovieBloc movieBloc;

  @override
  void initState() {
    super.initState();
    movieBloc = MovieBloc();
    movieBloc.add(GetMovieWithSessions(date: widget.date, movie: widget.movie));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: movieBloc,
      builder: (context, state) {
        return state is MovieInitial
            ? Circular()
            : state is MovieSuccessfulWithSessions
                ? Scaffold(
                    backgroundColor: Colors.black,
                    body: Center(
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Повернутись до перегляду усіх фільмів',
                                    style: TextStyle(
                                      color: Colors.deepPurple,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text('${widget.movie.name}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 27,
                                          fontWeight: FontWeight.w600)),
                                ),
                                SizedBox(height: 20),
                                Image.network(
                                  widget.movie.image,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Режисер - ${widget.movie.director}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Тривалість - ${widget.movie.duration}хв',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 20),
                                Wrap(
                                  children: [
                                    Text(
                                      'Сюжет - ${widget.movie.plot}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Рейтинг - ${widget.movie.rating}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Age(age: widget.movie.age),
                                  ],
                                ),
                                Text(
                                  'Сеанси на ${state.sessions[0].date.day.toString().padLeft(2, '0')}.${state.sessions[0].date.weekday.toString().padLeft(2, '0')}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                                for (int i = 0; i < state.sessions.length; i++)
                                  SessionInMovie(
                                      session: state.sessions[i],
                                      numberSession: i + 1),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(child: Text('erv'));
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
