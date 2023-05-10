import 'package:final_project/error.dart';
import 'package:final_project/features/home/presentation/home_general/circular.dart';
import 'package:final_project/features/movies/bloc/movie/movie_bloc.dart';
import 'package:final_project/features/movies/bloc/movie/movie_event.dart';
import 'package:final_project/features/movies/bloc/movie/movie_state.dart';
import 'package:final_project/features/movies/models/movie.dart';
import 'package:final_project/features/movies/presentation/movie.dart';
import 'package:final_project/features/movies/presentation/watch_film/age.dart';
import 'package:final_project/features/movies/presentation/watch_film/date.dart';
import 'package:final_project/features/movies/presentation/watch_film/session_in_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class WatchMovieWithSessions extends StatefulWidget {
  final Movie movie;
  final DateTime date;

  const WatchMovieWithSessions(
      {super.key, required this.movie, required this.date});

  @override
  State<WatchMovieWithSessions> createState() => _WatchMovieWithSessionsState();
}

class _WatchMovieWithSessionsState extends State<WatchMovieWithSessions> {
  late final MovieBloc movieBloc;
  final TextStyle styleGeneralText =
      const TextStyle(color: Colors.deepPurple, fontSize: 15);
  final TextStyle styleMovieText =
      const TextStyle(color: Colors.white, fontSize: 15);

  // late YoutubePlayerController controller;
  late int cIndex;
  List<DateTime> dates = [];

  @override
  void initState() {
    super.initState();
    movieBloc = MovieBloc();
    movieBloc.add(GetMovieWithSessions(date: widget.date, movie: widget.movie));
    DateTime now = DateTime.now();
    dates.add(now);
    for (int i = 0; i < 7; i++) {
      dates.add(dates[i].add(const Duration(days: 1)));
    }
    if (widget.date.day >= now.day) {
      cIndex = widget.date.day - now.day;
    } else {
      cIndex = now.day - widget.date.day;
    }
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: movieBloc,
      builder: (context, state) {
        return state is MovieInitial
            ? const Circular()
            : state is MovieSuccessfulWithSessions
                ? Scaffold(
                    backgroundColor: Colors.black,
                    body: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MoviePage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Повернутись до перегляду усіх фільмів',
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              Text(widget.movie.name,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 27,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(height: 20),
                              Image.network(
                                widget.movie.image,
                              ),
                              const SizedBox(height: 20),
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Оригінальна назва',
                                      style: styleGeneralText),
                                  Text(widget.movie.originalName,
                                      style: styleMovieText),
                                  const SizedBox(height: 30),
                                  Text('Тривалість', style: styleGeneralText),
                                  Text('${widget.movie.duration} хв',
                                      style: styleMovieText),
                                  const SizedBox(height: 30),
                                  Text('Країна / Студія',
                                      style: styleGeneralText),
                                  Text(
                                      '${widget.movie.country} / ${widget.movie.studio}',
                                      style: styleMovieText),
                                  const SizedBox(height: 30),
                                  Text('Режисери / Сценаристи',
                                      style: styleGeneralText),
                                  Text(
                                      '${widget.movie.director} / ${widget.movie.screenwriter}',
                                      style: styleMovieText),
                                  const SizedBox(height: 30),
                                  Text('Актори', style: styleGeneralText),
                                  Text('${widget.movie.starring} ',
                                      style: styleMovieText),
                                  const SizedBox(height: 30),
                                  Text('Сюжет', style: styleGeneralText),
                                  Wrap(
                                    children: [
                                      Text('${widget.movie.plot} ',
                                          style: styleMovieText),
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Рейтинг',
                                              style: styleGeneralText),
                                          RatingBar(
                                            itemSize: 30.0,
                                            // розмір однієї зірочки
                                            initialRating: double.parse(
                                                widget.movie.rating),
                                            // початковий рейтинг (від 0 до 5)
                                            allowHalfRating: true,

                                            ignoreGestures: true,
                                            // дозволяє виставляти

                                            // половинні зірочки
                                            ratingWidget: RatingWidget(
                                              full: const Icon(Icons.star,
                                                  color: Colors.deepPurple),
                                              // відображається для заповнених зірочок
                                              half: const Icon(Icons.star_half,
                                                  color: Colors.deepPurple),
                                              // відображається для половинних зірочок
                                              empty: const Icon(
                                                  Icons.star_border,
                                                  color: Colors
                                                      .deepPurple), // відображається для порожніх зірочок
                                            ),
                                            onRatingUpdate: (rating) {
                                              // викликається при зміні рейтингу
                                              print(
                                                  rating); // виводимо рейтинг у консоль
                                            },
                                          ),
                                        ],
                                      ),
                                      Age(age: widget.movie.age),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple),
                                onPressed: () {
                                  _launchURL(widget.movie.trailer);
                                },
                                child: const Text('Переглянути трейлер'),
                              ),
                              const SizedBox(height: 30),
                              // YoutubePlayerBuilder(
                              //   player: YoutubePlayer(controller: controller),
                              //   builder: (context, player) =>   Container(
                              //     height:300,
                              //       width:400,
                              //       child: player,
                              //     ),
                              //
                              //
                              // ),
                              const Text(
                                'Сеанси',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ),
                              SizedBox(
                                height: 80,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return TextButton(
                                          onPressed: () {
                                            setState(() {
                                              cIndex = index;
                                            });
                                            movieBloc.add(GetMovieWithSessions(
                                                date: dates[index],
                                                movie: widget.movie));
                                          },
                                          child: Date(
                                            dateTime: dates[index],
                                            isThisDate: index == cIndex,
                                          ),
                                        );
                                      },
                                      itemCount: 7),
                                ),
                              ),
                              for (int i = 0; i < state.sessions.length; i++)
                                SessionInMovie(
                                    session: state.sessions[i],
                                    numberSession: i + 1,
                                    movie: widget.movie),
                              const SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : const Text('error');
      },
      listener: (BuildContext context, Object? state) {
        if (state is MovieFailure) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ErrorPage(error: state.error)),
          );
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
    );
  }

  void _launchURL(String url) async {
    await launchUrl(Uri.parse(url));
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}
