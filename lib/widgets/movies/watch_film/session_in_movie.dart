import 'package:flutter/material.dart';

import '../../../models/session.dart';
import '../session/session.dart';

class SessionInMovie extends StatelessWidget {
  final Session session;
  final int numberSession;

  const SessionInMovie(
      {super.key, required this.session, required this.numberSession});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10,),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SessionPage(
                  session: session,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
          child: Container(
            height: 50,
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Сеанс ${numberSession}'),
                    SizedBox(height:5),
                    Text('Тип ${session.type}')
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${session.date.hour}:${session.date.minute}'),
                    Text('${session.minPrice}+'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
