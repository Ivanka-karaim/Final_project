
import 'package:final_project/widgets/movies/session/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/movie/movie_bloc.dart';
import '../../../bloc/movie/movie_event.dart';
import '../../../bloc/movie/movie_state.dart';
import '../../../models/movie.dart';

class WatchMovieWithSessions extends StatefulWidget{
  final AuthBloc authBloc;

  const WatchMovieWithSessions({super.key, required this.authBloc});

  @override
  State<WatchMovieWithSessions> createState() => _WatchMovieWithSessionsState();
}

class _WatchMovieWithSessionsState extends State<WatchMovieWithSessions> {
  late final MovieBloc movieBloc;
  late final Movie movie;
  late final DateTime date;

  // @override
  // void initState() {
  //   super.initState();
  //   didChangeDependencies();
  //
  //
  // }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateMyInheritedValue();
  }

  void _updateMyInheritedValue() {
    setState(() {
      movieBloc = MovieBloc();
      final Map<String, dynamic> arguments = ModalRoute
          .of(context)!
          .settings
          .arguments as Map<String, dynamic>;
      movie = arguments['movie'];
      // final bloc = arguments['bloc'] as MovieBloc;
      date = arguments['date'];

      movieBloc.add(GetMovieWithSessions(date: date, movie: movie));
    });
  }



  @override
  Widget build(BuildContext context) {
    return BlocConsumer(bloc: movieBloc, builder: (context, state) {
      return state is MovieSuccessfulWithSessions?
      Column(
        children: [
          Container(
            child: Text('${movie.name}'),),
          for(int i =0; i<state.sessions.length; i++)
            TextButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SessionPage(session: state.sessions[i])),
              );
            }, child: Text('${state.sessions[i].id}'))
        ],
      ):Container(child: Text('erv')) ;
    }, listener: (BuildContext context, Object? state) {},);
  }
}