import 'package:final_project/bloc/favourite/favourite_event.dart';
import 'package:final_project/bloc/favourite/favourite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/movie.dart';
import 'age.dart';
import 'package:final_project/bloc/favourite/favourite_bloc.dart';

class MovieOnePart extends StatefulWidget {
  Movie movie;
  final FavouriteBloc favouriteBloc;

  MovieOnePart({
    super.key,
    required this.movie,
    required this.favouriteBloc,
  });

  @override
  State<MovieOnePart> createState() => _MovieOnePartState();
}

class _MovieOnePartState extends State<MovieOnePart> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(bloc:widget.favouriteBloc,builder: (context, state) {
      return state is FavouriteSuccessful? Container(
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
                    widget.movie.smallImage,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 220,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 150,
                              child: Text(
                                widget.movie.name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                                maxLines: 1,
                                // максимальна кількість рядків, які може займати текст
                                overflow: TextOverflow.ellipsis, //
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(()  {
                                    print(state.movies.where((element) => element.id==widget.movie.id).length);
                                    if (state.movies.where((element) => element.id==widget.movie.id).length!=0){
                                      print("del");
                                      widget.favouriteBloc.add(DeleteMovieEvent(movie: widget.movie));
                                      widget.favouriteBloc.add(DeleteMovieEvent(movie: widget.movie));
                                    }else {
                                      print("ad");
                                      widget.favouriteBloc.add(
                                        AddFavouriteMovieEvent(
                                            movie: widget.movie),
                                      );
                                    }
                                    widget.favouriteBloc.add(GetFavouriteMovieEvent());
                                    });

                                },
                                icon: Icon(state.movies.where((element) => element.id==widget.movie.id).length!=0?Icons.favorite:Icons.favorite_outline, color: Colors.deepPurple,)),
                          ],
                        ),
                      ),
                      // SizedBox(height: 30),
                      Container(
                        width: 220,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Тривалість фільму: ${widget.movie.duration}хв'),
                                SizedBox(height: 10),
                                Text('Оцінка: ${widget.movie.rating}')
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Age(age: widget.movie.age),
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
      ):Text('');
    }, listener: (BuildContext context, Object? state) {  },);
  }
}
