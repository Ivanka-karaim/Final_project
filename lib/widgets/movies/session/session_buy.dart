import 'package:final_project/bloc/session/session_bloc.dart';
import 'package:final_project/bloc/session/session_event.dart';
import 'package:final_project/bloc/session/session_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/seat.dart';
import '../../../models/session.dart';

class SessionBuy extends StatefulWidget {
  final Session session;
  final List<Seat> seats;
  final SessionBloc sessionBloc;

  const SessionBuy({super.key, required this.session, required this.seats, required this.sessionBloc});

  @override
  State<SessionBuy> createState() => _SessionBuyState();
}

class _SessionBuyState extends State<SessionBuy> {


  @override
  void initState() {
    super.initState();
    // sessionBloc = SessionBloc();
    widget.sessionBloc
        .add(BookSeatsEvent(session: widget.session, seats: widget.seats));
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Назад'),
            ),
            Container(child: Text('buy')),
          ],
        );
  }
}
