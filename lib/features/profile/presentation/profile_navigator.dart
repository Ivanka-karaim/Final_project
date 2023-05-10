import 'package:final_project/features/home/bloc/auth/auth_bloc.dart';
import 'package:final_project/features/profile/bloc/profile/profile_bloc.dart';
import 'package:final_project/features/profile/presentation/profile.dart';
import 'package:final_project/features/profile/presentation/profile_info_tickets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileNavigator extends StatelessWidget {
  final AuthBloc authBloc;

  const ProfileNavigator({super.key, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProfileBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => ProfilePage(authBloc: authBloc),
          '/tickets': (context) => const ProfileInformationTicketsPage(),
        },
      ),
    );
  }
}
