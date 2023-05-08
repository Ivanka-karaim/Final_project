import 'package:flutter/material.dart';

import '../../../../models/seat.dart';

class SeatsChoose extends StatelessWidget {
  final List<Seat> seats;
  final List<int> rows;
  final Function deleteSeats;

  const SeatsChoose({super.key, required this.seats, required this.rows, required this.deleteSeats});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        for (int i = 0; i < seats.length; i++)
          Column(
            children: [
              SizedBox(height:10),
              Container(
                width: 200,
                height: 50,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.deepPurple, width: 1),
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width:10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ряд ${rows[i]}',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Місце ${seats[i].index}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Text('${seats[i].price}', style: TextStyle(color: Colors.white),),
                        IconButton(
                          style: IconButton.styleFrom(padding: EdgeInsets.all(0)),
                            onPressed: (){deleteSeats(i, seats[i]);},
                            icon: Icon(
                              Icons.close,
                              color: Colors.deepPurple,
                            ),),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
