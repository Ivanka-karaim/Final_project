import 'package:final_project/bloc/auth/auth_event.dart';
import 'package:flutter/material.dart';

import '../../bloc/auth/auth_bloc.dart';

class MoviePage extends StatelessWidget {
  final AuthBloc authBloc;

  const MoviePage({super.key, required this.authBloc});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home:Scaffold(
      body:Center(
        child: Column(
          children: [Text('films'),
          TextButton(onPressed: (){authBloc.add(RemoveUserEvent());}, child: Text('ВИдалити користувача'))],
        )
      )
    ), );
  }

}