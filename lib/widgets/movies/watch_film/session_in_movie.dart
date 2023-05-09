import 'package:flutter/material.dart';

import '../../../models/movie.dart';
import '../../../models/session.dart';
import '../session/session.dart';

class SessionInMovie extends StatelessWidget {
  final Session session;
  final int numberSession;
  final Movie movie;

  const SessionInMovie(
      {super.key, required this.session, required this.numberSession, required this.movie});

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
                builder: (context) =>
                    SessionPage(movie: movie, session: session),
              ),
            );
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
          child: Container(
            height: 50,
            width: 400,
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
                    Text('${session.date.hour.toString().padLeft(2, '0')}:${session.date.minute.toString().padLeft(2, '0')}'),
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
