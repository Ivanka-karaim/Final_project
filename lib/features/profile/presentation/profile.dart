import 'package:final_project/error.dart';
import 'package:final_project/features/home/bloc/auth/auth_bloc.dart';
import 'package:final_project/features/home/presentation/home_general/circular.dart';
import 'package:final_project/features/profile/bloc/profile/profile_bloc.dart';
import 'package:final_project/features/profile/bloc/profile/profile_event.dart';
import 'package:final_project/features/profile/bloc/profile/profile_state.dart';
import 'package:final_project/features/profile/presentation/profile_info.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        listener: (BuildContext context, Object? state) {
          if (state is ProfileFailure) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ErrorPage(error: state.error),
              ),
            );
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (BuildContext context, state) {
          return state is ProfileFailure
              ? ErrorPage(error: state.error)
              : state is ProfileInitial
                  ? const Circular()
                  : ProfileInformationPage(
                      authBloc: widget.authBloc,
                      state: state as ProfileInformation,
                      profileBloc: profileBloc);
        },
      ),
    );
  }
}
