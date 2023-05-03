import 'package:final_project/bloc/session/room/seats_choose.dart';
import 'package:final_project/widgets/movies/session/session_buy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/session/room/place.dart';
import '../../../bloc/session/session_bloc.dart';
import '../../../bloc/session/session_event.dart';
import '../../../models/seat.dart';
import '../../../models/session.dart';

class SessionPage extends StatefulWidget {
  final Session session;

  const SessionPage({super.key, required this.session});

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
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/',
                      );
                    },
                    child: Text('Переглянути усі фільми', style: TextStyle(color: Colors.deepPurple, decoration: TextDecoration.underline),),
                  ),
                  for (int i = 0; i < widget.session.room.rows.length; i++)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (int j = 0;
                            j < widget.session.room.rows[i].seats.length;
                            j++)
                          Place(sessionBloc: sessionBloc, row: widget.session.room.rows[i].index,  seat:  widget.session.room.rows[i].seats[j], addSeat: addSeat,)
                      ],
                    ),
                  SeatsChoose(deleteSeats: deleteSeat, seats: bookSeats, rows: rows,),
                  TextButton(
                    onPressed: () {
                      List<Seat> list = bookSeats;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SessionBuy(
                            session: widget.session,
                            seats: list,
                            sessionBloc: sessionBloc,
                          ),
                        ),
                      );
                    },
                    child: Text('Купити'),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
