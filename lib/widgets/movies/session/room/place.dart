import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/seat.dart';
import '../../../../models/session.dart';
import '../../../../bloc/session/session_bloc.dart';
import '../../../../bloc/session/session_event.dart';

class Place extends StatelessWidget {
  final SessionBloc sessionBloc;
  final Seat seat;
  final Function addSeat;
  final int row;
  final List<Seat> seatsChoose;

  const Place(
      {super.key,
      required this.row,
      required this.sessionBloc,
      required this.seat,
      required this.addSeat,
      required this.seatsChoose});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(0.0),
          margin: EdgeInsets.all(4.0),
          child: Container(
            width: 30,
            height: 30,
            child: seat.isAvailable
                ? ElevatedButton(
                    onPressed: () {
                      addSeat(row, seat);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: seatsChoose.contains(seat)?Colors.red: seat.type == 0
                            ? Colors.brown
                            : seat.type == 1
                                ? Colors.pink
                                : Colors.deepPurple,
                        padding: const EdgeInsets.all(0.0),),
                    child: Text(
                      '${seat.index}',
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                : Container(
                    color: Colors.grey,
                    child: Center(
                      child: Text(
                        '${seat.index}',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
