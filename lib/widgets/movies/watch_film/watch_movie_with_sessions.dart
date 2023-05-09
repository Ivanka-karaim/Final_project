import 'package:final_project/widgets/movies/session/session.dart';
import 'package:final_project/widgets/movies/watch_film/session_in_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/movie/movie_bloc.dart';
import '../../../bloc/movie/movie_event.dart';
import '../../../bloc/movie/movie_state.dart';
import '../../../models/movie.dart';
import '../../circular.dart';
import '../movie.dart';
import 'age.dart';
import 'date.dart';

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
      TextStyle(color: Colors.deepPurple, fontSize: 15);
  final TextStyle styleMovieText = TextStyle(color: Colors.white, fontSize: 15);
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
      dates.add(dates[i].add(Duration(days: 1)));
    }
    if ( widget.date.day>= now.day) {
      cIndex = widget.date.day - now.day;
    }else {
      cIndex = now.day-widget.date.day;
    }
    // cIndex = 0;
    // print(9999999);
    // final url = widget.movie.trailer;
    // final videoId = YoutubePlayer.convertUrlToId(url);
    // if (videoId != null) {
    //   print(22222222222222);
    //   controller = YoutubePlayerController(initialVideoId: videoId);
    // } else {
    //   print(11111111111111);
    //   controller = YoutubePlayerController(initialVideoId: '');
    // }

  }

  @override
  void deactivate(){
    super.deactivate();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: movieBloc,
      builder: (context, state) {
        return state is MovieInitial
            ? Circular()
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
                                      builder: (context) => MoviePage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Повернутись до перегляду усіх фільмів',
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text('${widget.movie.name}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 27,
                                        fontWeight: FontWeight.w600)),
                              ),
                              SizedBox(height: 20),
                              Image.network(
                                widget.movie.image,
                              ),
                              SizedBox(height: 20),
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Оригінальна назва',
                                      style: styleGeneralText),
                                  Text(widget.movie.originalName,
                                      style: styleMovieText),
                                  SizedBox(height: 30),
                                  Text('Тривалість', style: styleGeneralText),
                                  Text('${widget.movie.duration} хв',
                                      style: styleMovieText),
                                  SizedBox(height: 30),
                                  Text('Країна / Студія',
                                      style: styleGeneralText),
                                  Text(
                                      '${widget.movie.country} / ${widget.movie.studio}',
                                      style: styleMovieText),
                                  SizedBox(height: 30),
                                  Text('Режисери / Сценаристи',
                                      style: styleGeneralText),
                                  Text(
                                      '${widget.movie.director} / ${widget.movie.screenwriter}',
                                      style: styleMovieText),
                                  SizedBox(height: 30),
                                  Text('Актори', style: styleGeneralText),
                                  Text('${widget.movie.starring} ',
                                      style: styleMovieText),
                                  SizedBox(height: 30),
                                  Text('Сюжет', style: styleGeneralText),
                                  Wrap(
                                    children: [
                                      Text('${widget.movie.plot} ',
                                          style: styleMovieText),
                                    ],
                                  ),
                                  SizedBox(height: 30),
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
                                              full: Icon(Icons.star,
                                                  color: Colors.deepPurple),
                                              // відображається для заповнених зірочок
                                              half: Icon(Icons.star_half,
                                                  color: Colors.deepPurple),
                                              // відображається для половинних зірочок
                                              empty: Icon(Icons.star_border,
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
                              SizedBox(height: 30),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                                onPressed: () {
                                    _launchURL(widget.movie.trailer);
                                  },
                                      child: Text('Переглянути трейлер'),
                                        ),
                              SizedBox(height: 30),
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
                                      itemBuilder: (BuildContext context, int index) {
                                        return TextButton(
                                          onPressed: () {
                                            setState(() {
                                              cIndex = index;

                                            });
                                            movieBloc.add(GetMovieWithSessions(date: dates[index], movie: widget.movie));

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
                              SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(child: Text('erv'));
      },
      listener: (BuildContext context, Object? state) {},
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
