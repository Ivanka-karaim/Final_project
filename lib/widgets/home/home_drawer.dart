
import 'package:final_project/bloc/home/home_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home/home_bloc.dart';

class HomeDrawer extends StatelessWidget{
  final HomeBloc homeBloc;
  const HomeDrawer({super.key, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: Colors.white,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              border: Border.all(color:Colors.grey, width:0.5),
              // color: Colors.white,
            ),
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Cinema',
                  style: TextStyle(
                    // color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),

              ],
            ),
          ),
          ListTile(
            title: const Text('Фільми', style: TextStyle()),
            onTap: () {
              HomeBloc bloc = context.read<HomeBloc>();
              bloc.add(ChangeEvent(cIndex: 0));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Профіль'),
            onTap: () {
              HomeBloc bloc = context.read<HomeBloc>();
              bloc.add(ChangeEvent(cIndex: 1));
              Navigator.pop(context);
            },
          ),

        ],
      ),
    );
  }
}