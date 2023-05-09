import 'package:final_project/bloc/session/session_bloc.dart';
import 'package:final_project/bloc/session/session_event.dart';
import 'package:final_project/bloc/session/session_state.dart';
import 'package:final_project/widgets/movies/session/pdf.dart';
import 'package:final_project/widgets/movies/session/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/movie.dart';
import '../../../models/seat.dart';
import '../../../models/session.dart';
import '../../circular.dart';
import '../../home/home.dart';
import '../../login/input.dart';
import '../../profile/profile_info_tickets.dart';
import '../movie_navigator.dart';

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

  @override
  void initState() {
    super.initState();
    sessionBloc = SessionBloc();
    sessionBloc
        .add(BookSeatsEvent(session: widget.session, seats: widget.seats));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: sessionBloc,
        builder: (context, state) {
          return state is SessionInitial
              ? Circular()
              : state is SessionBook
                  ? Scaffold(
                      backgroundColor: Colors.black,
                      body: ListView(
                        children: [
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MovieNavigator(),
                                      ),
                                    );
                                  },
                                  child: Text('Відмінити покупку', style: TextStyle(color: Colors.deepPurple),),

                                ),
                                Text(
                                  'Загальна сума: ${widget.sum} грн',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Фільм: ${widget.movie.name}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Дата: ${widget.session.date.day.toString().padLeft(2, '0')}.${widget.session.date.month.toString().padLeft(2, '0')}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Час: ${widget.session.date.hour.toString().padLeft(2, '0')}.${widget.session.date.minute.toString().padLeft(2, '0')}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 20),
                                Text('Квитки: ',
                                    style: TextStyle(color: Colors.white)),
                                for (int i = 0; i < widget.seats.length; i++)
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                        'Ряд: ${widget.rows[i]}  Місце: ${widget.seats[i].index}',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                SizedBox(height: 30),
                                Input(
                                    controller: _controllerEmail,
                                    hint: 'aaa@gmail.com'),
                                SizedBox(height: 20),
                                Input(
                                    controller: _controllerCardNumber,
                                    hint: '0000-0000-0000-0000'),
                                SizedBox(height: 20),
                                Input(
                                    controller: _controllerExpirationDate,
                                    hint: '12/24'),
                                SizedBox(height: 20),
                                Input(controller: _controllerCVV, hint: '000'),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    _buy();
                                  },
                                  child: Text('Купити'),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Text('error'),
                      ],
                    );
        },
        listener: (context, state) {
          if (state is BuySuccessful) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieNavigator(),
              ),
            );
          } else if (state is SessionFailure) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieNavigator(),
              ),
            );

            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Error')));
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

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieNavigator(),
      ),
    );
  }
}
