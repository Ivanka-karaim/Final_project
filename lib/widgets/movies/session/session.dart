import 'package:final_project/bloc/session/session_state.dart';
import 'package:final_project/widgets/movies/session/room/place.dart';
import 'package:final_project/widgets/movies/session/room/seats_choose.dart';
import 'package:final_project/widgets/movies/session/session_buy.dart';
import 'package:final_project/widgets/movies/watch_film/watch_movie_with_sessions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/session/session_bloc.dart';
import '../../../bloc/session/session_event.dart';
import '../../../models/movie.dart';
import '../../../models/seat.dart';
import '../../../models/session.dart';
import '../../circular.dart';

class SessionPage extends StatefulWidget {
  final Session session;
  final Movie movie;

  const SessionPage({super.key, required this.movie, required this.session});

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  late final SessionBloc sessionBloc;
  List<Seat> bookSeats = [];
  List<int> rows = [];

  @override
  void initState() {
    sessionBloc = SessionBloc();
    sessionBloc.add(GetSessionEvent(sessionId: widget.session.id));
    super.initState();
  }

  void addSeat(int row, Seat seat) {
    setState(() {
      bookSeats.add(seat);
      rows.add(row);
    });
  }

  void deleteSeat(int ind){
    setState(() {
      rows.removeAt(ind);
      bookSeats.removeAt(ind);
    });
  }

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => SessionBloc())],
      child: BlocConsumer(
        bloc: sessionBloc,
        builder: (context, state) {
          return state is SessionInitial?Circular():state is SessionObject?Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WatchMovieWithSessions(movie: widget.movie, date:widget.session.date,

                          ),
                        ),
                      );
                    },
                    child: Text('Повернутись до фільму', style: TextStyle(color: Colors.deepPurple, decoration: TextDecoration.underline),),
                  ),
                  Text('${widget.movie.name}',style: TextStyle(color: Colors.white),),
                  Text('${state.session.date}', style: TextStyle(color: Colors.white),),
                  for (int i = 0; i < state.session.room.rows.length; i++)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (int j = 0;
                            j < state.session.room.rows[i].seats.length;
                            j++)
                          Place(sessionBloc: sessionBloc, row: state.session.room.rows[i].index,  seat:  state.session.room.rows[i].seats[j], addSeat: addSeat,)
                      ],
                    ),
                  SeatsChoose(deleteSeats: deleteSeat, seats: bookSeats, rows: rows,),
                  ElevatedButton(
                    onPressed: () {
                      List<Seat> list = bookSeats;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SessionBuy(
                            session: state.session,
                            seats: list,
                            sessionBloc: sessionBloc,
                            movie: widget.movie,

                          ),
                        ),
                      );
                    },
                    child: Text('Купити'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                  ),
                ],
              ),
            ),
          ):Text('Error');
        },
        listener: (context, state) {},
      ),
    );
  }

  @override
  void dispose(){
    super.dispose();
    bookSeats = [];
    rows = [];
  }
}
