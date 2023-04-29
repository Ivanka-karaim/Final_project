import 'package:final_project/bloc/home/home_bloc.dart';
import 'package:final_project/widgets/home/home_drawer.dart';
import 'package:final_project/widgets/movies/movie.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/home/home_state.dart';
import '../app_bar.dart';


class HomeProvider extends StatefulWidget {
  final AuthBloc authBloc;
  const HomeProvider({super.key, required this.authBloc});

  @override
  State<HomeProvider> createState() => _HomeProviderState();
}

class _HomeProviderState extends State<HomeProvider> {
  late final HomeBloc homeBloc;

  @override
  void initState(){
    homeBloc = HomeBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Scaffold(
              drawer: HomeDrawer(homeBloc: homeBloc,),
              appBar: CustomAppBar(),
              body: SafeArea(
                top: false,
                // controller: tabController,
                child: IndexedStack(
                  index: state.cIndex,
                  children:  [
                    MoviePage(authBloc: widget.authBloc),
                  ],
                ),
              ),
            ); }
      ), );
  }
}