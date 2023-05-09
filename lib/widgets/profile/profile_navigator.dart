
import 'package:final_project/bloc/auth/auth_bloc.dart';
import 'package:final_project/bloc/profile/profile_state.dart';
import 'package:final_project/widgets/profile/profile.dart';
import 'package:final_project/widgets/profile/profile_info_tickets.dart';
import 'package:final_project/widgets/profile/user_tickets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/profile/profile_bloc.dart';

class ProfileNavigator extends StatelessWidget{
  final AuthBloc authBloc;

  const ProfileNavigator({super.key, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
        BlocProvider(create: (context) => ProfileBloc()),
    ],child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => ProfilePage(authBloc: authBloc),
        '/tickets' : (context) => ProfileInformationTicketsPage( ),

      },
    ), );
  }

}