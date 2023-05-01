import 'package:flutter/material.dart';

import '../../../models/movie.dart';

class MovieOnePart extends StatelessWidget {
  Movie movie;

  MovieOnePart({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: SizedBox(
        height: 150,
        child: Row(
          children: [
            Image.network(
              movie.smallImage,
              width: 100,
              height: 100,
            ),
            Column(
              children: [Text('${movie.name}'), Text('${movie.duration}')],
            ),
            Column(
              children: [
                Text('${movie.age}+'),
                Text('${movie.rating}'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
