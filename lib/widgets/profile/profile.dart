import 'package:final_project/bloc/auth/auth_event.dart';
import 'package:final_project/bloc/profile/profile_bloc.dart';
import 'package:final_project/bloc/profile/profile_event.dart';
import 'package:final_project/bloc/profile/profile_state.dart';
import 'package:final_project/widgets/home/home.dart';
import 'package:final_project/widgets/profile/profile_info.dart';
import 'package:final_project/widgets/profile/profile_info_tickets.dart';
import 'package:final_project/widgets/profile/user_tickets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';

class ProfilePage extends StatefulWidget {
  final AuthBloc authBloc;

  const ProfilePage({super.key, required this.authBloc});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileBloc profileBloc;

  @override
  void initState() {
    profileBloc = ProfileBloc();
    profileBloc.add(GetUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProfileBloc()),
      ],
      child: BlocConsumer(
        bloc: profileBloc,
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, state) {
          return state is ProfileFailure
              ? HomePage(authBloc: widget.authBloc)
              : state is ProfileInitial
              ? const SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          )
              :
          ProfileInformationPage(authBloc: widget.authBloc, state: state as ProfileInformation,profileBloc:profileBloc);
          //     :
          // ProfileInformationTicketsPage(
          //   state: state as ProfileInformationTickets, authBloc: widget.authBloc,);
        },
      ),
    );
  }
}
