import 'package:final_project/features/home/bloc/favourite/favourite_bloc.dart';
import 'package:final_project/features/home/bloc/favourite/favourite_event.dart';
import 'package:final_project/features/home/bloc/favourite/favourite_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/movie.dart';
import 'age.dart';

class MovieOnePart extends StatefulWidget {
  final Movie movie;
  final FavouriteBloc favouriteBloc;

  const MovieOnePart({
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
    return BlocConsumer(
      bloc: widget.favouriteBloc,
      builder: (context, state) {
        return state is FavouriteSuccessful
            ? Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.deepPurple, width: 1),
                      color: Colors.black),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      height: 100,
                      width: 400,
                      child: Row(
                        children: [
                          Image.network(
                            widget.movie.smallImage,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                width: 220,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
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
                                          setState(() {
                                            if (state.movies
                                                    .where((element) =>
                                                        element.id ==
                                                        widget.movie.id)
                                                    .length !=
                                                0) {
                                              widget.favouriteBloc.add(
                                                  DeleteMovieEvent(
                                                      movie: widget.movie));
                                              widget.favouriteBloc.add(
                                                  DeleteMovieEvent(
                                                      movie: widget.movie));
                                            } else {
                                              widget.favouriteBloc.add(
                                                AddFavouriteMovieEvent(
                                                    movie: widget.movie),
                                              );
                                            }
                                            widget.favouriteBloc
                                                .add(GetFavouriteMovieEvent());
                                          });
                                        },
                                        icon: Icon(
                                          state.movies
                                                      .where((element) =>
                                                          element.id ==
                                                          widget.movie.id)
                                                      .length !=
                                                  0
                                              ? Icons.favorite
                                              : Icons.favorite_outline,
                                          color: Colors.deepPurple,
                                        )),
                                  ],
                                ),
                              ),
                              // SizedBox(height: 30),
                              SizedBox(
                                width: 220,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Тривалість фільму: ${widget.movie.duration}хв'),
                                        const SizedBox(height: 10),
                                        Text('Оцінка: ${widget.movie.rating}')
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
              )
            : const Text('');
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
