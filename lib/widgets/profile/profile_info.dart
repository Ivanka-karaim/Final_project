import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/profile/profile_event.dart';
import '../../bloc/profile/profile_state.dart';

class ProfileInformationPage extends StatelessWidget {
  final ProfileInformation state;
  final AuthBloc authBloc;
  final ProfileBloc profileBloc;

  ProfileInformationPage(
      {super.key, required this.state, required this.authBloc, required this.profileBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Column(
          children: [
            Text(
              '${state.user?.name}',
              style: TextStyle(color: Colors.white),
            ),
            TextButton(
                onPressed: () async {
                  Navigator.pushNamed(context, '/tickets', );
                  // Navigator.pop(context);
                },
                child: Text('Переглянути куплені квитки')),
            TextButton(
                onPressed: () {
                  authBloc.add(RemoveUserEvent());
                },
                child: Text('Вийти з профілю')),

          ],
        )));
  }
}
