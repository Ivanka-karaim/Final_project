import 'package:final_project/features/session/bloc/session/session_bloc.dart';
import 'package:final_project/features/session/models/seat.dart';
import 'package:flutter/material.dart';



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
          padding: const EdgeInsets.all(0.0),
          margin: const EdgeInsets.all(4.0),
          child: SizedBox(
            width: 25,
            height: 25,
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
                      style: const TextStyle(fontSize: 12),
                    ),
                  )
                : Container(
                    color: Colors.grey,
                    child: Center(
                      child: Text(
                        '${seat.index}',
                        style: const TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
