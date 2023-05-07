import 'package:final_project/bloc/profile/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/profile/profile_state.dart';
import '../circular.dart';
import '../home/home.dart';

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
    return BlocConsumer(
      bloc: profileBloc,
      listener: (context, state) {},
      builder: (context, state) {
        return state is ProfileInitial
            ? Circular()
            : state is ProfileInformationTickets
                ? Scaffold(
                    backgroundColor: Colors.black,
                    body: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/');
                            },
                            child: Text(
                              'Повернутись у профіль',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 50),
                          Text(
                            'Ваші квитки',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '${state.tickets.length}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                : Text('Error');
      },
    );
  }
}
