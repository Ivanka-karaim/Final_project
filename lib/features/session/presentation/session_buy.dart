import 'dart:async';

import 'package:final_project/error.dart';
import 'package:final_project/features/home/presentation/home_general/circular.dart';
import 'package:final_project/features/movies/models/movie.dart';
import 'package:final_project/features/movies/presentation/movie_navigator.dart';
import 'package:final_project/features/session/bloc/session/session_bloc.dart';
import 'package:final_project/features/session/bloc/session/session_event.dart';

import 'package:final_project/features/login/presentation/input.dart';
import 'package:final_project/features/session/bloc/session/session_state.dart';
import 'package:final_project/features/session/models/seat.dart';
import 'package:final_project/features/session/models/session.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionBuy extends StatefulWidget {
  final Session session;
  final List<Seat> seats;
  final Movie movie;
  final SessionBloc sessionBloc;
  final int sum;
  final List<int> rows;

  const SessionBuy(
      {super.key,
      required this.session,
      required this.seats,
      required this.sessionBloc,
      required this.movie,
      required this.sum,
      required this.rows});

  @override
  State<SessionBuy> createState() => _SessionBuyState();
}

class _SessionBuyState extends State<SessionBuy> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerCardNumber = TextEditingController();
  final TextEditingController _controllerExpirationDate =
      TextEditingController();
  final TextEditingController _controllerCVV = TextEditingController();
  late final SessionBloc sessionBloc;

  final TextStyle styleGeneralText =
      const TextStyle(color: Colors.deepPurple, fontSize: 15);
  final TextStyle styleMovieText =
      const TextStyle(color: Colors.white, fontSize: 15);
  late Timer _timer;
  int _secondsLeft = 15 * 60;

  @override
  void initState() {
    super.initState();
    sessionBloc = SessionBloc();
    sessionBloc
        .add(BookSeatsEvent(session: widget.session, seats: widget.seats));
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsLeft--;
      });
      if (_secondsLeft == 0) {
        timer.cancel();
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: sessionBloc,
        builder: (context, state) {
          return state is SessionInitial || state is BuySuccessful
              ? const Circular()
              : state is SessionBook || state is BuyError
                  ? Scaffold(
                      resizeToAvoidBottomInset: false,
                      backgroundColor: Colors.black,
                      body: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListView(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MovieNavigator(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Відмінити покупку',
                                    style: TextStyle(color: Colors.deepPurple),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Покупка квитків',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 30),
                                    ),
                                    Text(
                                      ' ${(_secondsLeft ~/ 60).toString().padLeft(2, '0')}:${(_secondsLeft % 60).toString().padLeft(2, '0')}',
                                      style: styleGeneralText,
                                    ),
                                  ],
                                ),
                                Container(
                                    height: 1,
                                    width: 300,
                                    color: Colors.deepPurple),
                                const SizedBox(height: 30),
                                Text('Загальна сума', style: styleGeneralText),
                                Text(widget.sum.toString(),
                                    style: styleMovieText),
                                const SizedBox(height: 30),
                                Text('Фільм / Дата / Час',
                                    style: styleGeneralText),
                                Text(
                                    '${widget.movie.name} / ${widget.session.date.day.toString().padLeft(2, '0')}.${widget.session.date.month.toString().padLeft(2, '0')} / ${widget.session.date.hour.toString().padLeft(2, '0')}.${widget.session.date.minute.toString().padLeft(2, '0')}',
                                    style: styleMovieText),
                                const SizedBox(height: 30),
                                const SizedBox(height: 20),
                                Text('Квитки: ', style: styleGeneralText),
                                for (int i = 0; i < widget.seats.length; i++)
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                        'Ряд: ${widget.rows[i]}  Місце: ${widget.seats[i].index}',
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ),
                                const SizedBox(height: 30),
                                Text(
                                  state is BuyError ? state.error : '',
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'Адреса електронної пошти',
                                  style: styleGeneralText,
                                ),
                                Input(
                                  controller: _controllerEmail,
                                  hint: 'aaa@gmail.com',
                                  obscure: false,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Номер карти',
                                  style: styleGeneralText,
                                ),
                                Input(
                                  controller: _controllerCardNumber,
                                  hint: '0000-0000-0000-0000',
                                  obscure: false,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Дата доки карта дійсна',
                                  style: styleGeneralText,
                                ),
                                Input(
                                  controller: _controllerExpirationDate,
                                  hint: '12/24',
                                  obscure: false,
                                  isDate: true,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'CVV',
                                  style: styleGeneralText,
                                ),
                                Input(
                                  controller: _controllerCVV,
                                  hint: '000',
                                  obscure: true,
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    _buy();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple),
                                  child: const Text('Купити'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : const Text('error');
        },
        listener: (context, state) {
          if (state is BuySuccessful) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MovieNavigator(),
              ),
            );
          } else if (state is SessionFailure) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ErrorPage(error: state.error)),
            );
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));

            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Error')));
          } else if (state is BuyError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        });
  }

  _buy() {
    String email = _controllerEmail.text;
    String cardNumber = _controllerCardNumber.text;
    String expirationDate = _controllerExpirationDate.text;
    String cvv = _controllerCVV.text;
    sessionBloc.add(BuySeatsEvent(
        sessionId: widget.session.id,
        seats: widget.seats,
        cardNumber: cardNumber,
        expirationDate: expirationDate,
        cvv: cvv,
        email: email));
  }
}
