import 'package:flutter/material.dart';

import 'logo.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: const Text('CiNeMa'),
        elevation: 0,
        backgroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.white,
              width: 0.5), // колір та товщина межі
        ),
        actions: [
          IconButton(
            icon: const Logo(width: 50,),
            onPressed: () {},
          ),
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}
