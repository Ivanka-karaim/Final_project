import 'package:final_project/bloc/profile/profile_event.dart';
import 'package:final_project/widgets/movies/movie_navigator.dart';
import 'package:final_project/widgets/profile/profile_navigator.dart';
import 'package:final_project/widgets/profile/qr_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/profile/profile_state.dart';
import '../circular.dart';
import '../home/home.dart';
import '../movies/session/pdf.dart';

class ProfileInformationTicketsPage extends StatefulWidget {
  // final AuthBloc authBloc;

  const ProfileInformationTicketsPage({
    super.key,
    // required this.authBloc,
  });

  @override
  State<ProfileInformationTicketsPage> createState() =>
      _ProfileInformationTicketsPageState();
}

class _ProfileInformationTicketsPageState
    extends State<ProfileInformationTicketsPage> {
  late final ProfileBloc profileBloc;
  

  @override
  void initState() {
    profileBloc = ProfileBloc();
    profileBloc.add(GetUserTicketsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer(
        bloc: profileBloc,
        listener: (context, state) {
          if (state is ProfileFailure){
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          return state is ProfileInitial
              ? Circular()
              : state is ProfileInformationTickets
                  ? Scaffold(
                      backgroundColor: Colors.black,
                      body: ListView(
                        children: [
                          Center(
                            child: Column(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/');
                                  },
                                  child: const Text(
                                    'Повернутись у профіль',
                                    style: TextStyle(
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 50),
                                Text(
                                  'Ваші квитки',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w400),
                                ),
                                for (int i = 0; i < state.tickets.length; i++)
                                  Column(
                                    children: [
                                      SizedBox(height: 20),
                                      Container(
                                        width: 350,
                                        height: 70,
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.deepPurple,
                                                width: 1),
                                            color: Colors.black,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4.0,
                                                horizontal: 20.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      state.tickets[i].name,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      '${state.tickets[i].date.day.toString().padLeft(2, '0')}.${state.tickets[i].date.month.toString().padLeft(2, '0')}',
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight.w400,),
                                                    ),
                                                  ],
                                                ),
                                                QrAndButton(ticket: state.tickets[i])
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : MovieNavigator();
        },
      ),
    );
  }
}
