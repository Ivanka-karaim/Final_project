import 'package:final_project/widgets/movies/session/session_buy.dart';
import 'package:flutter/material.dart';

import '../../../models/seat.dart';
import '../../../models/session.dart';

class SessionPage extends StatefulWidget {
  final Session session;

  const SessionPage({super.key, required this.session});

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  List<Seat> bookSeats=[];

  @override
  Widget build(BuildContext context) {
    print("12345");
    return Scaffold(
        body: Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          TextButton(onPressed: (){Navigator.pushNamed(context, '/', );
          }, child: Text('Переглянути усі фільми'),),
          for (int i = 0; i < widget.session.room.rows.length; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int j = 0; j < widget.session.room.rows[i].seats.length; j++)
                  widget.session.room.rows[i].seats[j].isAvailable
                      ? TextButton(
                          onPressed: () {
                            setState(() {
                              bookSeats.add(widget.session.room.rows[i].seats[j]);
                            });
                          },
                          child:
                              Text('${widget.session.room.rows[i].seats[j].index} '),
                        )
                      : Text('${widget.session.room.rows[i].seats[j].index} ', style: TextStyle(color: Colors.red)),
              ],
            ),
          for(int i=0;i<bookSeats.length; i++)
            Text('${bookSeats[i].index}'),

          TextButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SessionBuy(session: widget.session, seats: bookSeats,), ),
            );
          },
              child:Text('Купити'),),
        ],
      ),
    ));
  }
}
