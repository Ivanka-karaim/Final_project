import 'package:final_project/features/home/bloc/auth/auth_bloc.dart';
import 'package:final_project/features/home/bloc/home/home_bloc.dart';
import 'package:final_project/features/home/bloc/home/home_state.dart';
import 'package:final_project/features/home/presentation/favourite_movies.dart';
import 'package:final_project/features/home/presentation/home_drawer.dart';
import 'package:final_project/features/home/presentation/home_general/app_bar.dart';
import 'package:final_project/features/movies/presentation/movie_navigator.dart';
import 'package:final_project/features/profile/presentation/profile_navigator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeProvider extends StatefulWidget {
  final AuthBloc authBloc;

  const HomeProvider({super.key, required this.authBloc});

  @override
  State<HomeProvider> createState() => _HomeProviderState();
}

class _HomeProviderState extends State<HomeProvider> {
  late final HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = HomeBloc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
        if (state is HomeResultState) {}
      }, builder: (context, state) {
        return Scaffold(
          drawer: HomeDrawer(
            homeBloc: homeBloc,
            authBloc: widget.authBloc,
          ),
          appBar: const CustomAppBar(),
          body: SafeArea(
            top: false,
            // controller: tabController,
            child: IndexedStack(
              index: state.cIndex,
              children: [
                const MovieNavigator(),
                ProfileNavigator(authBloc: widget.authBloc),
                const FavouriteMovies(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
