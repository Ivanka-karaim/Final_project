import 'package:final_project/widgets/movies/session/session_buy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  void initState() {
    sessionBloc = SessionBloc();
    sessionBloc.add(GetSessionEvent(sessionId: widget.session.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("12345");
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => SessionBloc())],
      child: BlocConsumer(
        bloc: sessionBloc,
        builder: (context, state) {
          return Scaffold(
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
                    child: Text('Переглянути усі фільми'),
                  ),
                  for (int i = 0; i < widget.session.room.rows.length; i++)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (int j = 0;
                            j < widget.session.room.rows[i].seats.length;
                            j++)
                          widget.session.room.rows[i].seats[j].isAvailable
                              ? TextButton(
                                  onPressed: () {
                                    setState(() {
                                      bookSeats.add(
                                          widget.session.room.rows[i].seats[j]);
                                    });
                                  },
                                  child: Text(
                                      '${widget.session.room.rows[i].seats[j].index} '),
                                )
                              : Text(
                                  '${widget.session.room.rows[i].seats[j].index} ',
                                  style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  for (int i = 0; i < bookSeats.length; i++)
                    Text('${bookSeats[i].index}'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SessionBuy(
                            session: widget.session,
                            seats: bookSeats,
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
