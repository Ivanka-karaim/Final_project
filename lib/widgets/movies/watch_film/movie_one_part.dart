import 'package:flutter/material.dart';

import '../../../models/movie.dart';
import 'age.dart';

class MovieOnePart extends StatelessWidget {
  Movie movie;

  MovieOnePart({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.deepPurple, width: 1),
            color: Colors.black),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Container(
            height: 100,
            width: 400,
            child: Row(
              children: [
                Image.network(
                  movie.smallImage,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Container(
                      width: 220,
                      child: Text(
                        movie.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                        maxLines: 1,
                        // максимальна кількість рядків, які може займати текст
                        overflow: TextOverflow.ellipsis, //
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: 220,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Тривалість фільму: ${movie.duration}хв'),
                              SizedBox(height: 10),
                              Text('Оцінка: ${movie.rating}')
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             Age(age:movie.age),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
