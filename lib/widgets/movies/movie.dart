import 'package:final_project/bloc/movie/movie_event.dart';
import 'package:final_project/bloc/movie/movie_state.dart';
import 'package:final_project/widgets/movies/watch_film/date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/movie/movie_bloc.dart';
import '../home/home.dart';

class MoviePage extends StatefulWidget {
  final AuthBloc authBloc;

  const MoviePage({super.key, required this.authBloc});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> with TickerProviderStateMixin {
  int cIndex = 0;
  List<DateTime> dates = [];

  late final MovieBloc movieBloc;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    dates.add(now);
    for(int i=0; i<7; i++) {
      dates.add(dates[i].add(Duration(days: 1)));
    }
    movieBloc = MovieBloc();
    movieBloc.add(GetMoviesEvent(date: now));
  }


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [ BlocProvider(create: (context) => MovieBloc()),], child: Scaffold(
      body: Column(
          children: [
            SizedBox(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return TextButton(
                        onPressed: (){movieBloc.add(GetMoviesEvent(date: dates[index]));},
                        child: Date(text:dates[index].toString()),
                      );
                    },
                    itemCount: 7),
              ),
            ),
            Text('films'),
            BlocConsumer(bloc: movieBloc, builder: (context, state){
              print(999);
              return state is MovieInitial? const SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ), ): state is MovieSuccessful? Text('${state.movies}'):HomePage(authBloc: widget.authBloc,);
            }, listener: (context, state){

            }),
          ],
        ),
      ),
    );
  }
}
