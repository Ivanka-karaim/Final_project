import 'package:final_project/bloc/session/session_state.dart';
import 'package:final_project/widgets/movies/movie_navigator.dart';
import 'package:final_project/widgets/movies/session/room/place.dart';
import 'package:final_project/widgets/movies/session/room/seats_choose.dart';
import 'package:final_project/widgets/movies/session/session_buy.dart';
import 'package:final_project/widgets/movies/watch_film/watch_movie_with_sessions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/session/session_bloc.dart';
import '../../../bloc/session/session_event.dart';
import '../../../error.dart';
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
  int sum = 0;

  @override
  void initState() {
    sessionBloc = SessionBloc();
    sessionBloc.add(GetSessionEvent(sessionId: widget.session.id));
    super.initState();
  }


  void addSeat(int row, Seat seat) {
    bookSeats.contains(seat)? deleteSeat(bookSeats.indexOf(seat), seat):
    setState(() {
      bookSeats.add(seat);
      rows.add(row);
      sum = sum + seat.price;
    });
  }

  void deleteSeat(int ind, Seat seat) {
    setState(() {
      rows.removeAt(ind);
      bookSeats.removeAt(ind);
      sum = sum - seat.price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => SessionBloc())],
      child: BlocConsumer(
        bloc: sessionBloc,
        builder: (context, state) {
          return state is SessionFailure? MovieNavigator()
              : state is SessionObject
                  ? Scaffold(
                      backgroundColor: Colors.black,
                      body: Center(
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        WatchMovieWithSessions(
                                      movie: widget.movie,
                                      date: widget.session.date,
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                'Повернутись до фільму',
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            Text(
                              widget.movie.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Дата: ${state.session.date.day.toString().padLeft(2, '0')}.${state.session.date.month.toString().padLeft(2, '0')}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Text(
                                  'Час: ${state.session.date.hour.toString().padLeft(2, '0')}:${state.session.date.minute.toString().padLeft(2, '0')}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            for (int i = 0;
                                i < state.session.room.rows.length;
                                i++)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  for (int j = 0;
                                      j <
                                          state.session.room.rows[i].seats
                                              .length;
                                      j++)
                                    Place(
                                        sessionBloc: sessionBloc,
                                        row: state.session.room.rows[i].index,
                                        seat:
                                            state.session.room.rows[i].seats[j],
                                        addSeat: addSeat,
                                        seatsChoose: bookSeats)
                                ],
                              ),
                            Text(
                              'Кімната: ${state.session.room.name}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: 20),
                                Container(
                                  height: 20,
                                  width: 20,
                                  color: Colors.deepPurple,
                                ),
                                Text(
                                  '-  VIP',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Container(
                                  height: 20,
                                  width: 20,
                                  color: Colors.pink,
                                ),
                                Text(
                                  '-  BETTER',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Container(
                                  height: 20,
                                  width: 20,
                                  color: Colors.brown,
                                ),
                                Text(
                                  '-  NORMAL',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 20),
                              ],
                            ),
                            SeatsChoose(
                              deleteSeats: deleteSeat,
                              seats: bookSeats,
                              rows: rows,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Загальна сума: ${sum} грн',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 20),
                            Container(
                              child:bookSeats.length!=0? ElevatedButton(
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
                                        sum: sum,
                                        rows: rows,
                                      ),
                                    ),
                                  );
                                },
                                child: Text('Купити'),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple),
                              ):Text(''),
                            ),
                          ],
                        ),
                      ),
                    )
                  :Circular();
        },
        listener: (context, state) {
          if (state is SessionFailure){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ErrorPage(error: state.error)
              ),
            );
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bookSeats = [];
    rows = [];
  }
}
