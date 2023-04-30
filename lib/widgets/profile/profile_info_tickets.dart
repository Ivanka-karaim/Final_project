
import 'package:flutter/material.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/profile/profile_state.dart';

class ProfileInformationTicketsPage extends StatelessWidget {
  final AuthBloc authBloc;

  const ProfileInformationTicketsPage(
      {super.key, required this.authBloc, });


  @override
  Widget build(BuildContext context) {
    final state = profileBloc.state;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Column(
              children: [
                Text(
                  '${state.tickets}',
                  style: TextStyle(color: Colors.white),
                ),
                // TextButton(
                //     onPressed: () {
                //       ProfileBloc bloc = context.read<ProfileBloc>();
                //       bloc.add(GetUserTicketsEvent());
                //     },
                //     child: Text('Переглянути куплені квитки')),
                // TextButton(
                //     onPressed: () {
                //       authBloc.add(RemoveUserEvent());
                //     },
                //     child: Text('Вийти з профілю')),

              ],
            )));
  }
}