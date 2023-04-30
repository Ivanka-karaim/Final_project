import 'package:final_project/bloc/profile/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/profile/profile_state.dart';
import '../home/home.dart';

class ProfileInformationTicketsPage extends StatefulWidget {
  final AuthBloc authBloc;

  const ProfileInformationTicketsPage({super.key, required this.authBloc,});

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
        bloc: profileBloc, listener: (context, state) {}, builder:
        (context, state) {
      return state is ProfileInitial? const SizedBox(
        width: 50.0,
        height: 50.0,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ):state is ProfileInformationTickets ? Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            children: [

              Text('Tickets', style: TextStyle(color: Colors.white),),
              Text(
                '${state.tickets}',
                style: TextStyle(color: Colors.white),
              ),
              TextButton(child:Text('Назад'), onPressed: (){
                Navigator.pop(context);
              }),

            ],
          ),),) : HomePage(authBloc: widget.authBloc);
    },
    );
  }
}