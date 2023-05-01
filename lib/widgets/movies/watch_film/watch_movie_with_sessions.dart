
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
  final Movie movie;
  final DateTime date;


  const WatchMovieWithSessions({super.key, required this.authBloc, required this.movie, required this.date});

  @override
  State<WatchMovieWithSessions> createState() => _WatchMovieWithSessionsState();
}

class _WatchMovieWithSessionsState extends State<WatchMovieWithSessions> {
  late final MovieBloc movieBloc;


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
      movieBloc.add(GetMovieWithSessions(date: widget.date, movie: widget.movie));
    });
  }



  @override
  Widget build(BuildContext context) {
    return BlocConsumer(bloc: movieBloc, builder: (context, state) {
      return state is MovieSuccessfulWithSessions?
      Column(
        children: [
          Container(
            child: Text('${widget.movie.name}'),),
          for(int i =0; i<state.sessions.length; i++)
            TextButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SessionPage(session: state.sessions[i],)),
              );
            }, child: Text('${state.sessions[i].id}'))
        ],
      ):Container(child: Text('erv')) ;
    }, listener: (BuildContext context, Object? state) {},);
  }
}