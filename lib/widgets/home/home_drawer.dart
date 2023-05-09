
import 'package:final_project/bloc/home/home_event.dart';
import 'package:final_project/widgets/favourite_movies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/home/home_bloc.dart';
import '../profile/profile_navigator.dart';

class HomeDrawer extends StatelessWidget{
  final HomeBloc homeBloc;
  final AuthBloc authBloc;
  const HomeDrawer({super.key, required this.homeBloc, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(

            margin: EdgeInsets.zero,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '   Cinema',
                  style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),

              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: 0.5,

          ),
          SizedBox(height:40),
          ListTile(
            title: const Text('   Фільми', style: TextStyle(color: Colors.white, fontSize: 20)),
            onTap: () {
              HomeBloc bloc = context.read<HomeBloc>();
              bloc.add(ChangeEvent(cIndex: 0));
              Navigator.pop(context);
            },
          ),
          SizedBox(height:20),
          ListTile(
            title: const Text('   Профіль', style: TextStyle(color: Colors.white, fontSize: 20)),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ProfileNavigator(authBloc: authBloc),
              //   ),
              // );
              HomeBloc bloc = context.read<HomeBloc>();
              bloc.add(ChangeEvent(cIndex: 1));
              Navigator.pop(context);
            },
          ),
          SizedBox(height:20),
          ListTile(
            title: const Text('   Вподобані', style: TextStyle(color: Colors.white, fontSize: 20)),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => FavouriteMovies(),
              //   ),
              // );
              HomeBloc bloc = context.read<HomeBloc>();
              bloc.add(ChangeEvent(cIndex: 2));
              Navigator.pop(context);
            },
          ),

        ],
      ),
    );
  }
}